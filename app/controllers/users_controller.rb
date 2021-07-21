class UsersController < ApplicationController

  def new
  end

  def create
    # Call the service to make the user in the BE db
    RegistrationService.register_user(
      {
        email: params[:email],
        verify_email: params[:verify_email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
      }
    )
    # Find user in the FE db if it was created
    user = User.find_by(email: params[:email])
    if user
      session[:user_id] = user.id
      flash[:success] = "Congratulations, you have successfully registered and are now logged in!\n Using the email: #{user.email}"
      redirect_to root_path
    else
      flash[:danger] = "There was a problem registering you. Please try again."
      render :new
    end
  end
end
