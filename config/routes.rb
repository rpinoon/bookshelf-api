Rails.application.routes.draw do
  get '/current_user', to: 'user#index'
  get '/books', to: 'books#index'
  get '/book', to: 'books#show'
  resources :list_items

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