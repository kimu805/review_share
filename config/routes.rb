Rails.application.routes.draw do
  devise_for :users
  resources :works
end
  resources :works, only: [:index, :show]
end