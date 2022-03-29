class CancelPassword < ApplicationService
  def initialize(id)
    @id = id
  end

  def call
    password = Password.find(@id)
    password.canceled = true
    password.save

    return true
  end
end