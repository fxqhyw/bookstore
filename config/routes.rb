Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  root 'home#index'
  match '/catalog', to: 'books#index', via: 'get'
  resources :books, only: [:index, :show]
  resources :order_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show, :update]
end
