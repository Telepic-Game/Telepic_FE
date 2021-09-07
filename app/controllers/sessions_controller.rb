class SessionsController < ApplicationController

  def new
  end

  def create
     # Call the service to log in verify player info on the BE db
    login = LoginService.player_login(
      {
        email: params[:email],
        password_digest: params[:password],
      }
      )
    if login == true
      player = Player.find_by(email: params[:email])
      session[:player_id] = player.id
      flash[:success] = "You have been logged in successfully!"
      redirect_to login_root_path
    elsif login == false
      flash[:danger] = "Invalid email or password"
      redirect_to login_new_path
    end
  end

  def destroy
    if session[:player_id] == current_player.id
      session[:player_id] = nil
      flash[:success] = "You have been logged out successfully!"
      redirect_to root_path
    else
      # Add flash message?
      return
    end
  end
end
