class PlayersController < ApplicationController

  def new
  end

  def create
    if (params[:password].match(/(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!*()_-])(?=.*[0-9])/)) && (params[:verify_email] == params[:email]) && (params[:password] == params[:password_confirmation])
    # Call the service to make the player in the BE db
      # can_register = RegistrationService.register_player(
      #   {
      #     email: params[:email],
      #     verify_email: params[:verify_email],
      #     password: params[:password],
      #     password_confirmation: params[:password_confirmation],
      #   }
      # )
      can_register = Player.create(
        {
          email: params[:email]
        }
      )
      require "pry"; binding.pry
      if can_register[:response] && can_register[:permissions] == "registered"
      # Find player in the FE db if it was created
        player = Player.create(
          email: can_register[:email],
          be_id: can_register[:be_id],
        )
        session[:player_id] = player.id
        flash[:success] = "Congratulations, you have successfully registered and are now logged in!"
        redirect_to login_root_path
      else
        flash[:danger] = "There was a problem registering you. Please try again."
        render :new
      end
    else
      flash[:danger] = "There was a problem registering you. Please try again."
      render :new
    end
  end
end
