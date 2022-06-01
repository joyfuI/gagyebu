# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts
  resources :account_groups, only: %i[create update destroy]
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'
end
