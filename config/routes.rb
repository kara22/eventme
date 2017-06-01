Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update]
  resources :events, only: [:index]
  get "search" => "users#search"
  root to: "pages#home"
end
