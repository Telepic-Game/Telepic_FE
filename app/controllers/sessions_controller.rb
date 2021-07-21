class SessionsController < ApplicationController

  def new
  end

  def create
     # Call the service to log in verify user info on the BE db
    login = LoginService.user_login(
      {
        email: params[:email],
        password_digest: params[:password],
      }
    )
    if login == true
      user = User.find_by(email: params[:email])
      session[:user_id] = user.id
      flash[:success] = "You have been logged in successfully!"
      redirect_to login_root_path
    elsif login == false
      flash[:danger] = "Invalid email or password"
      redirect_to login_new_path
    end
  end

  def destroy
    session[@current_user.id] = nil
    redirect_to root_path
  end
end
