class PasswordQueue < ApplicationService
  def call
    Password.where("start_attendance is null and canceled is false").length
  end
end