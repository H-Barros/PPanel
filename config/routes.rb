Rails.application.routes.draw do
  root "home#home"

  resources :passwords
  devise_for :users, controllers: { registrations: "registrations" }

  get "/attendance", to: "attendance#panel"
  get "/nextpassword", to: "passwords#next_password"
end