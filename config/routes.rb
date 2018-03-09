Rails.application.routes.draw do
  root to: 'genres#index'
  resources :genres do
    resources :packs, only: [:show]
  end
  get 'contacts', to: 'genres#contacts'
  get 'price_list', to: 'genres#price_list'
  post 'images', to: 'packs#inc_views'

  resources :packs, only: [:show]
end
