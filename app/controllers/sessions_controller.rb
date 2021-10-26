class SessionsController < ApplicationController

  def new
  end

  def create
    if !(Player.find_by(email: params[:email])).nil?
      player = Player.find_by(email: params[:email])
    end

    if player
      if player.password == params[:password]
        session[:player_id] = player.id
        flash[:success] = "You have been logged in successfully!"
        redirect_to login_root_path
      else
        flash[:danger] = "Invalid email or password"
        redirect_to login_new_path
      end
    else
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
