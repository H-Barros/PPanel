module Intake
  class PasswordPreferentialController < ApplicationController
    def new
      @form = Intake::PasswordPreferentialForm.new
    end

    def create
      @form = Intake::PasswordPreferentialForm.new(password_preferential_params)
      if @form.valid?
        full_params = password_preferential_params.merge(session[:password_service]).merge(session[:password_sector])
        create_password = CreatePasswordForm.new(full_params)

        if create_password.save
          redirect_to new_intake_password_sector_form_path, notice: 'Thank you'
        else
          render :new
        end
      else
        render :new
      end
    end

    private

    def password_preferential_params
      params.require(:intake_password_preferential_form).permit(:preferential)
    end
  end
end