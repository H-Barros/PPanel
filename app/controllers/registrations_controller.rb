class RegistrationsController < Devise::RegistrationsController
    protected
  
    def after_sign_up_path_for(resource)
        "/users/sign_in"
    end

    def after_sign_out_path_for(resource)
        "/"
      end
  end