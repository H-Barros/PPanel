class NextPassword < ApplicationService
  def call
    @next_password = next_password()

    if @next_password != {"message": "Indisponible"}
      @next_password.start_attendance = Time.new
      #@next_password.user_id = current_user.id
      @next_password.save
    end

    @next_password
  end

  private

  def next_password_preferential?
    lasts_two_passwords = Password.where("start_attendance is not null").order(start_attendance: :desc).limit(2)

    if lasts_two_passwords.length < 2
      return true
    elsif lasts_two_passwords[0].preferential && lasts_two_passwords[1].preferential
      return false
    else
      return true
    end
  end

  def next_password
    preferential_passwords = Password.where(preferential: true, start_attendance: nil).order(created_at: :asc).limit(1)
    general_passwords = Password.where(preferential: false, start_attendance: nil).order(created_at: :asc).limit(1)

    if PasswordQueue.call() == 0
      password = {"message": "Indisponible"}
    elsif next_password_preferential? && !preferential_passwords.empty?
      password = Password.find(preferential_passwords[0].id)
    elsif !next_password_preferential? && !general_passwords.empty?
      password = Password.find(general_passwords[0].id)
    elsif next_password_preferential? && preferential_passwords.empty?
      password = Password.find(general_passwords[0].id)
    elsif !next_password_preferential? && general_passwords.empty?
      password = Password.find(preferential_passwords[0].id)
    end

    return password
  end
end