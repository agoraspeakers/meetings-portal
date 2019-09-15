# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    match 'users/auth/failure', to: 'users/omniauth_callbacks#failure', via: %i[get post]
  end

  resources :users, only: %i[index show] do
    resource :roles, only: %i[create destroy], controller: 'users/roles'
  end
end
