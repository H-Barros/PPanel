class AttendanceController < ApplicationController

    def panel
        @passwords_in_queue = Password.passwords_in_queue
    end

    def next_password
        next_password = Password.next_password

        if next_password != {"message": "Indisponible"}
          next_password.start_attendance = Time.new
          next_password.desk = params[:desk]
          next_password.user_id = current_user.id
          next_password.save
        end
        
        ActionCable.server.broadcast("attendance_channel",{passwords_in_queue: "#{Password.passwords_in_queue}"})
        ActionCable.server.broadcast("client_panel_channel",{passwords: Password.last_answered_passwords(6).as_json, next_password: next_password})

        render json: next_password
    end

    def recall_password
        password_to_recall = Password.find(params[:id])

        ActionCable.server.broadcast("client_panel_channel",{passwords: Password.last_answered_passwords(6).as_json, next_password: password_to_recall})
        
        render json: password_to_recall
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
