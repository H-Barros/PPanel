class EndPassword < ApplicationService
  def initialize(id)
    @id = id
  end

  def call
    password = Password.find(@id)
    password.end_attendance = Time.new
    password.save

    return true
  end
end