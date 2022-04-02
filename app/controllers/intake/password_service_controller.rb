module Intake
  class PasswordServiceController < ApplicationController
    def new
      @form = Intake::PasswordServiceForm.new
    end

    def create
      @form = Intake::PasswordServiceForm.new(password_service_params)
      if @form.valid?
        session[:password_service] = {"service" => @form.service}

        redirect_to new_intake_password_preferential_form_path, notice: 'Thank you'
      else
        render :new
      end
    end

    private

    def password_service_params
      params.require(:intake_password_service_form).permit(:service)
    end
  end
end