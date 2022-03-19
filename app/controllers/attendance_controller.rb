class AttendanceController < ApplicationController

    def panel
    end

    def next_password
        @next_password = Password.next_password
        if @next_password != {"message": "Indisponible"}
          @next_password.start_attendance = Time.new
          @next_password.user_id = current_user.id
          @next_password.save
        end
    
        render json: @next_password
    end

    def end_password
        password = Password.find(params[:id])
        password.end_attendance = Time.new
        password.save

        render json: {"message": "Finished"}
    end

    def cancel_password
        password = Password.find(params[:id])
        password.canceled = true
        password.save

        render json: {"message": "Canceled"}
    end
end
