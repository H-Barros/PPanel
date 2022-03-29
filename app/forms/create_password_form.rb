class CreatePasswordForm
  include ActiveModel::Model

  attr_accessor :preferential, :sector, :service

  validates :preferential, inclusion: ["1", "0"]
  validates :sector, :service, presence: true

  def initialize(params = {})
    super(params)
    password_number_generator()
  end

  def save
    return false unless valid?

    password = Password.new(number: @number, sector: @sector, service: @service, preferential: @preferential)
    
    password.save

    return true
  end

  private

  def password_number_generator
    @preferential ? pwd_number = "P" : pwd_number = "G"

    if Password.last == nil
      pwd_number += "0001"
    else 
      password_number = Password.last.id + 1
      pwd_number += "000#{password_number.to_s}"
    end

    @number = pwd_number
  end
end