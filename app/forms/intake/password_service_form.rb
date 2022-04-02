module Intake
  class PasswordServiceForm
    include ActiveModel::Model
    attr_accessor :service
    validates :service, presence: true
  end
end