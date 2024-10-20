Rails.application.routes.draw do
  root to: "works#index"
  devise_for :users
  resources :works, only: [:index, :show]
end