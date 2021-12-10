class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_player, :authorized, :logged_in

  def current_player
    # require "pry"; binding.pry
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end

  def authorized
    redirect_to login_path if logged_in == false
  end

  def logged_in
    !!current_player
  end
end
