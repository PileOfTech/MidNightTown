Rails.application.routes.draw do
  root to: 'genres#index'
  resources :genres do
    resources :packs, only: [:show]
  end
  resources :packs, only: [:show]
end
