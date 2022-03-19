class CreatePasswordForm
  include ActiveModel::Model

  attr_accessor :preferential, :sector, :service

  validates :preferential, inclusion: [true, false]
  validates :sector, :service, presence: true

  def initialize(sector, service, preferential = false)
    @sector = sector
    @service = service
    @preferential = preferential
  end

  def save
    return false unless valid?

    password = Password.new(sector: @sector, service: @service, preferential: @preferential)
    password.password_number_generator
    password.save
  end
end