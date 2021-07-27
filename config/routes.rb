Rails.application.routes.draw do
  root to: 'home#index'

  # Player routes
  get '/login', to: 'sessions#new', as: 'login_new'
  post '/login', to: 'sessions#create', as: 'login_create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  # Player registration page
  get '/register', to: 'players#new', as: 'register'
  # Create the new player
  post '/register', to: 'players#create', as: 'register_player'
  # Delete the player
  delete '/delete_player', to: 'players#destroy', as: 'delete_player'

  # After being logged in or registered, waiting_room paths
  get '/login_root', to: 'login#root', as: 'login_root'
  get '/new_waiting_room', to: 'waiting_room#new'
  # ? AJAX? Websocket?
  get '/waiting_room', to: 'waiting_room#index'
  post '/waiting_room', to: 'waiting_room#create'
end
