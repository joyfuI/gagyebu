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
  resources :account_groups, only: %i[create update destroy] do
    member do
      patch :up
      put :up
      patch :down
      put :down
    end
  end

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'
end
