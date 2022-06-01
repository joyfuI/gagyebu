# frozen_string_literal: true

Rails.application.routes.draw do
  resources :account_groups
  devise_for :users

  root 'home#index'
end
