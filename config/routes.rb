Rails.application.routes.draw do
  devise_for :users
  resources :works, only: [:index, :show]
end