module Intake
  class PasswordPreferentialController < ApplicationController
    def new
      @form = Intake::PasswordPreferentialForm.new
    end

    def create
      @form = Intake::PasswordPreferentialForm.new(password_preferential_params)
      if @form.valid?
        session[:password_preferential] = {"preferential" => @form.preferential}

        redirect_to confirm_create_password_forms_path, notice: 'Thank you'
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