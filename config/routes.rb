Rails.application.routes.draw do
  resources :comments
  resources :boards
  resources :users
  root "application#hello"
end
