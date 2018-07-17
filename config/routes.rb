Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  match '/catalog', to: 'books#index', via: 'get'
end
