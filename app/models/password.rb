class Password < ApplicationRecord
  belongs_to :user

  def password_number_generator
    self.preferential ? pwd_number = "P" : pwd_number = "G"
    Password.last == nil ? pwd_number += "0001" : pwd_number += "000#{Password.last.id.to_s}"

    self.number = pwd_number
  end    
end
