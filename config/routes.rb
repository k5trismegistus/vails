require 'sidekiq/web'

Rails.application.routes.draw do
  root 'videos#index'

  resources :videos, only: [:show]
  resources :taggings, only: [:create, :destroy]
  mount Sidekiq::Web => '/sidekiq'
end
