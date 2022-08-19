Rails.application.routes.draw do
  get '/current_user', to: 'user#index'
  get '/books', to: 'books#index'
  get '/book', to: 'books#show'
  get '/discover', to: 'books#discover'
  resources :list_items
  get '/to_read', to: 'list_items#to_read'
  get '/finished', to: 'list_items#finished'

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