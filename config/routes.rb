Rails.application.routes.draw do
  root "home#home"

  namespace :intake do
    resources :password_sector_forms, controller: "password_sector", only: %i[new create]
    resources :password_service_forms, controller: "password_service", only: %i[new create]
    resources :password_preferential_forms, controller: "password_preferential", only: %i[new create]
  end

  resources :passwords
  resources :create_password_forms, controller: "create_passwords", only: %i[show new create]
  devise_for :users, controllers: { registrations: "registrations" }

  get "/attendance", to: "attendance#panel"
  get "/nextpassword", to: "attendance#next_password"
  get "/recallpassword/:id", to: "attendance#recall_password"
  get "/endpassword/:id", to: "attendance#end_password"
  get "/cancelpassword/:id", to: "attendance#cancel_password"

  get "/clientpanel", to:"client_panel#index"
  
  get "/report", to: "reports#report"
end