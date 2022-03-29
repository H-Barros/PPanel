class Password < ApplicationRecord
  belongs_to :user, optional: true

  def password_number_generator
    self.preferential ? pwd_number = "P" : pwd_number = "G"

    if Password.last == nil
      pwd_number += "0001"
    else 
      password_number = Password.last.id + 1
      pwd_number += "000#{password_number.to_s}"
    end

    self.number = pwd_number
  end

  def self.passwords_in_queue
    disponible_passwords = self.where("start_attendance is ?", nil)

    return disponible_passwords.length
  end

  def self.next_password_preferential?
    lasts_two_passwords = self.where("start_attendance is not ?", nil).order(start_attendance: :desc).limit(2)

    if lasts_two_passwords.length < 2
      return true
    elsif lasts_two_passwords[0].preferential && lasts_two_passwords[1].preferential
      return false
    else
      return true
    end
  end

    def self.next_password
      preferential_passwords = self.where(preferential: true, start_attendance: nil).order(created_at: :asc).limit(1)
      general_passwords = self.where(preferential: false, start_attendance: nil).order(created_at: :asc).limit(1)

      if self.passwords_in_queue == 0
        password = {"message": "Indisponible"}
      elsif self.next_password_preferential? && !preferential_passwords.empty?
        password = self.find(preferential_passwords[0].id)
      elsif !self.next_password_preferential? && !general_passwords.empty?
        password = self.find(general_passwords[0].id)
      elsif self.next_password_preferential? && preferential_passwords.empty?
        password = self.find(general_passwords[0].id)
      elsif !self.next_password_preferential? && general_passwords.empty?
        password = self.find(preferential_passwords[0].id)
      end

      return password
    end

    def self.lasts_passwords(number)
      self.order(start_attendance: :desc).limit(number)
    end
end
