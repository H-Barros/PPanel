Rails.application.routes.draw do
  resources :passwords
  devise_for :users, controllers: { registrations: "registrations" }

  root "home#home"
end