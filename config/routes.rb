Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  root 'home#index'
  match '/catalog', to: 'books#index', via: 'get'
  resources :books
  resource :cart, only: [:show]
end
