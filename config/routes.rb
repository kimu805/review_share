Rails.application.routes.draw do
  devise_for :users
  resources :works
  post "works/import_from_tmdb", to: "works#import_from_tmdb", as: "import_from_tmdb"
end
