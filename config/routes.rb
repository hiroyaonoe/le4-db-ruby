Rails.application.routes.draw do
  resources :categories
  resources :comments
  resources :boards
  resources :users
  root "application#hello"
end
