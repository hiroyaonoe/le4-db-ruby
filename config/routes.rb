Rails.application.routes.draw do
  resources :tags
  resources :categories
  resources :comments
  resources :boards
  resources :users
  root "application#hello"
end
