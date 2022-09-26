# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :user_books

    get '/current_user', to: 'user#index'
    get '/books', to: 'books#index'
    get '/book', to: 'books#show'
    get '/discover', to: 'books#discover'
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }
end
