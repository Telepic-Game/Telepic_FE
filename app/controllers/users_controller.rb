class UsersController < ApplicationController

  def new
  end

  def create
    # Call the service to make the user in the BE db
    can_register = RegistrationService.register_user(
      {
        email: params[:email],
        verify_email: params[:verify_email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
      }
    )
    if can_register[:response]
    # Find user in the FE db if it was created
      user = User.create(
        email: can_register[:email],
        be_id: can_register[:be_id],
      )
      session[:user_id] = user.id
      flash[:success] = "Congratulations, you have successfully registered and are now logged in!\n   Usingthe email: #{user.email}"
      redirect_to root_path
    else
      flash[:danger] = "There was a problem registering you. Please try again."
      render :new
    end
  end
end
