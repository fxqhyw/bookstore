Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks', sessions: 'sessions',
                                    registrations: 'registrations' }
  root 'home#index'
  get '/catalog', to: 'books#index'
  resources :books, only: %i[index show]
  resources :order_items, only: %i[create update destroy]
  resource :cart, only: %i[show update]
  resources :orders, only: %i[index show]
  resources :reviews, only: :create
  resources :checkouts

  scope '/settings' do
    resource :address, only: :update
    get '/address', to: 'addresses#edit'
    as :user do
      get '/privacy', to: 'devise/registrations#edit'
    end
  end
end
