class CreatePasswordsController < ApplicationController
  def index
  end

  def new
    @form = CreatePasswordForm.new
    puts current_user.id
  end

  def create
    @form = CreatePasswordForm.new(create_password_form_params)
    if @form.save
      redirect_to root_path, notice: 'Thank you'
    else
      render :new
    end
  end

  private

  def create_password_form_params
    puts params
    params.require(:create_password_form).permit(:sector, :service, :preferential)
  end
end