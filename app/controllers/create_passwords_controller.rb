class CreatePasswordsController < ApplicationController
  before_action :set_password, only: %i[show]

  def show
  end

  def confirm
    @form = CreatePasswordForm.new(create_password_form_params)
  end

  def create
    @form = CreatePasswordForm.new(create_password_form_params)
    if @form.save
      redirect_to create_password_form_url(@form.linked_password), notice: 'Thank you'
    else
      render :new
    end
  end

  private
  def set_password
    @password = Password.find(params[:id])
  end

  def create_password_form_params
    recovered_session = [session[:password_sector], session[:password_service], session[:password_preferential]]
    recovered_session.inject(&:merge)
  end  
end