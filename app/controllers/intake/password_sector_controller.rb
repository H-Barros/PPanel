module Intake
  class PasswordSectorController < ApplicationController
    def new
      @form = Intake::PasswordSectorForm.new
    end

    def create
      @form = Intake::PasswordSectorForm.new(password_sector_params)
      if @form.valid?
        session[:password_sector] = {"sector" => @form.sector}

        redirect_to new_intake_password_service_form_path, notice: 'Thank you'
      else
        render :new
      end
    end

    private

    def password_sector_params
      params.require(:intake_password_sector_form).permit(:sector)
    end
  end
end