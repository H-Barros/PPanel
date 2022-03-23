class PasswordsController < ApplicationController
  before_action :set_password, only: %i[ show edit update destroy ]

  def index
    @passwords = Password.all
  end

  def show
  end

  def new
    @password = Password.new
    ActionCable.server.broadcast("password_queue_channel",{passwords_in_queue: "#{Password.passwords_in_queue}"})
  end

  def create
    @password = Password.new(password_params)
    @password.password_number_generator

    respond_to do |format|
      if @password.save
        format.html { redirect_to new_password_path, notice: "Password was successfully created." }
        format.json { render :show, status: :created, location: @password }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @password.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @password.update(password_params)
        format.html { redirect_to password_url(@password), notice: "Password was successfully updated." }
        format.json { render :show, status: :ok, location: @password }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @password.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_password
      @password = Password.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def password_params
      params.require(:password).permit(:number, :preferential, :sector, :service, :user_id, :canceled, :start_attendance, :end_attendance)
    end
end
