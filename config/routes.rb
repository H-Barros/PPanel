Rails.application.routes.draw do
  root "home#home"

  resources :passwords
  resources :create_password_forms, controller: "create_passwords"
  devise_for :users, controllers: { registrations: "registrations" }

  get "/attendance", to: "attendance#panel"
  get "/nextpassword", to: "attendance#next_password"
  get "/endpassword/:id", to: "attendance#end_password"
  get "/cancelpassword/:id", to: "attendance#cancel_password"
  get "/report", to: "reports#report"
end