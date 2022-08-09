Rails.application.routes.draw do
  resources :boards
  resources :users
  root "application#hello"
end
