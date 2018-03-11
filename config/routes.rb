Rails.application.routes.draw do
  root to: 'genres#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :genres do
    resources :packs, only: [:show]
  end
  get 'contacts', to: 'genres#contacts'
  get 'price_list', to: 'genres#price_list'
  post 'images', to: 'packs#inc_views'
  post 'download', to: 'packs#download' 
  
  resources :packs, only: [:show] do
  end
end
