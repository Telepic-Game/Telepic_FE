Rails.application.routes.draw do
  root to: 'home#index'

  # User routes
  get '/login', to: 'sessions#new', as: 'login_new'
  post '/login', to: 'sessions#create', as: 'login_create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  # User registration page
  get '/register', to: 'users#new', as: 'register'
  # Create the new user
  post '/register', to: 'users#create', as: 'register_user'
  # Delete the user
  delete '/delete_user', to: 'users#destroy', as: 'delete_user'

  # After being logged in or registered
  get '/login_root', to: 'login#root', as: 'login_root'
end
