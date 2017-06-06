Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update] do
      get 'eventme_pictures_set' => 'users#eventme_pictures_set'
      get 'pictures' => 'users#pictures'
      get 'receiver' => 'users#receiver'
      patch 'update_picture' => 'users#update_picture'
      patch 'update_description' => 'users#update_description'
    end
  get "search" => "users#search"
  resources :events, only: [:index]
  resources :decisions, only: [:create, :update]
  resources :matches, only: [:index, :show, :destroy] do
    resources :messages, only: [:create, :destroy]
  end

  root to: "pages#home"
end
