Rails.application.routes.draw do
  get '/current_user', to: 'user#index'
  get '/books', to: 'books#index'
  get '/book', to: 'books#show'
  get '/discover', to: 'books#discover'
  resources :user_books
  get '/to_read', to: 'user_books#to_read'
  get '/finished', to: 'user_books#finished'

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