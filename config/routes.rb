# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }

  devise_scope :user do
    match 'users/auth/failure', to: 'users/omniauth_callbacks#failure', via: %i[get post]
  end

  root to: 'pages#index'
end
