class HomeController < ApplicationController
    before_action :authenticate_user!, only: %i[]
    
    def home
        
    end
end
