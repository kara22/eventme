Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update] do
      get 'eventme_pictures_set' => 'users#eventme_pictures_set'
      get 'pictures' => 'users#pictures'
      patch 'update_picture' => 'users#update_picture'
    end
  get "search" => "users#search"
  resources :events, only: [:index]
  root to: "pages#home"
end
