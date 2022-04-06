class CreatePasswordsController < ApplicationController
  after_action :broadcast_passwords_in_queue, only: %i[confirm]
  after_action :clear_session, only: %i[create]

  def confirm
    # não pode retornar para essa ação
    @form = CreatePasswordForm.new(create_password_form_params)
  end

  def create
    @form = CreatePasswordForm.new(create_password_form_params)
    if @form.save
      redirect_to password_url(@form.linked_password), notice: 'Thank you'
    else
      render :confirm
    end
  end

  private
  def create_password_form_params
    recovered_session = [session[:password_sector], session[:password_service], session[:password_preferential]]
    recovered_session.inject(&:merge)
  end

  def broadcast_passwords_in_queue
    ActionCable.server.broadcast("attendance_channel",{passwords_in_queue: "#{Password.passwords_in_queue}"})
  end

  def clear_session
    session.delete("password_sector")
    session.delete("password_service")
    session.delete("password_preferential")
  end
end