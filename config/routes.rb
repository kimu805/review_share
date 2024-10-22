Rails.application.routes.draw do
  root to: "works#index"
  devise_for :users
  resources :works, only: [:index, :show]
  get "works/search", to: "works#search", as: "search_works"
end