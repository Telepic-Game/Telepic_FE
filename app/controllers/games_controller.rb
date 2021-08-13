class GamesController < ApplicationController
  def start
    GameService.start_game(params[:email])
  end
end
