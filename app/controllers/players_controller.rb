class PlayersController < ApplicationController

  def new
  end

  def create
    if (params[:password].match(/(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!*()_-])(?=.*[0-9])/)) && (params[:verify_email] == params[:email]) && (params[:password] == params[:password_confirmation]) && !params[:email].blank? && !params[:verify_email].blank? && Player.find_by(email: params[:email]).nil?
      player = Player.create(
        {
          email: params[:email],
          permissions: "registered"
        }
      )
      if player.save
        session[:player_id] = player.id
        flash[:success] = "Congratulations, you have successfully registered and are now logged in!"
        redirect_to login_root_path
      end
    else
      flash[:danger] = "There was a problem registering you. Please try again."
      render :new
    end
  end
end
