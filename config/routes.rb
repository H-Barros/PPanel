Rails.application.routes.draw do
  resources :passwords
  devise_for :users

  devise_scope :user do
    root "devise/sessions#new"
  end
end
