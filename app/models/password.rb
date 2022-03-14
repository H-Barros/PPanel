class Password < ApplicationRecord
  belongs_to :user, optional: true

  def password_number_generator
    self.preferential ? pwd_number = "P" : pwd_number = "G"
    Password.last == nil ? pwd_number += "0001" : pwd_number += "000#{Password.last.id.to_s}"

    self.number = pwd_number
  end

  def self.passwords_in_queue
    disponible_passwords = self.where("start_attendance is null")

    return disponible_passwords.length
  end

  def self.next_password_preferencial?
    lasts_two_passwords = self.where("start_attendance is not null").order(start_attendance: :desc).limit(2)

    if lasts_two_passwords[0].preferential && lasts_two_passwords[1].preferential
      return false
    else
      return true
    end
  end

    def self.next_password
      preferential_passwords = self.where(preferencial: true, inicio_atendimento: nil).order(created_at: :asc).limit(1)
      general_passwords = self.where(preferencial: false, inicio_atendimento: nil).order(created_at: :asc).limit(1)

      if self.passwords_in_queue == 0
        password = "Indisponible"
      elsif self.next_password_preferencial? && !preferential_passwords.empty?
        password = self.find(preferential_passwords[0].id)
        password.start_attendance = Time.new
        password.user_id = current_user.id
        password.save
      elsif !self.next_password_preferencial? && !general_passwords.empty?
        password = self.find(general_passwords[0].id)
        password.start_attendance = Time.new
        password.user_id = current_user.id
        password.save
      elsif self.next_password_preferencial? && preferential_passwords.empty?
        password = self.find(general_passwords[0].id)
        password.start_attendance = Time.new
        password.user_id = current_user.id
        password.save
      elsif !self.next_password_preferencial? && general_passwords.empty?
        password = self.find(preferential_passwords[0].id)
        password.start_attendance = Time.new
        password.user_id = current_user.id
        password.save
      end

      return password
    end
end
