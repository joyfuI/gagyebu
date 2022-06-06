# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts, except: [:show] do
    member do
      patch :up
      put :up
      patch :down
      put :down
    end
  end
  resources :account_groups, only: %i[create update destroy]
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'
end
