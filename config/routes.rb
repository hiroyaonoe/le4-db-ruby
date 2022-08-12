Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, path: "auth", controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }
  resources :boards, only: [:show, :create, :destroy] do
    resources :comments, only: [:create]
  end
  resources :users
end
