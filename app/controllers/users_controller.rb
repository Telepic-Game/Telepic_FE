class UsersController < ApplicationController

  def new
  end

  def create
    RegistrationService.register_user(
      {
        email: params[:email],
        verify_email: params[:verify_email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
      }
    )
    require 'pry'; binding.pry
    # Create a session too
  end
end
