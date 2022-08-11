Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
  end
  resources :boards do
    resources :comments, only: [:create]
  end
  resources :users
end
