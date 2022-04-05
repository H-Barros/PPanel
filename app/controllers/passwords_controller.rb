class PasswordsController < ApplicationController
  before_action :set_password, only: %i[ show ]

  def index
    @passwords = Password.all
  end

  def show
  end

  private
    def set_password
      @password = Password.find(params[:id])
    end
end
