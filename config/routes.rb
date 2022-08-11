Rails.application.routes.draw do
  get 'static_pages/home'
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
