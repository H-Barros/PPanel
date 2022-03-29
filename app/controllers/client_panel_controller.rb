class ClientPanelController < ApplicationController
    before_action :authenticate_user!, only: %i[]
    
    def index
        
    end
end