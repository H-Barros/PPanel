module Intake
  class PasswordPreferentialForm
    include ActiveModel::Model
    attr_accessor :preferential
    validates :preferential, inclusion: ["1", "0"]
  end
end