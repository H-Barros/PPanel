module Intake
  class PasswordSectorForm
    include ActiveModel::Model
    attr_accessor :sector
    validates :sector, presence: true
  end
end