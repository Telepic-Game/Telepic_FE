Rails.application.routes.draw do
  root to: 'home#index'

  # User routes
  get '/login', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  # User registration page
  get '/register', to: 'users#new', as: 'register'
  # Create the new user
  post '/register', to: 'users#create', as: 'register_user'
  # Delete the user
  delete '/delete_user', to: 'users#destroy', as: 'delete_user'
end
