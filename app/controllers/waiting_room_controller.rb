class WaitingRoomController < ApplicationController
  def index
    @waiting_room = WaitingRoomService.get_back_end_waiting_room(current_player.email)
    # require "pry"; binding.pry
    @username = @waiting_room[:data][:attributes][:player][:current_player][:username]
    @room_code = @waiting_room[:data][:attributes][:waiting_room][:room_code]
    @all_players = @waiting_room[:data][:attributes][:player][:all_players]
  end

  def new
  end
# create waiting room and host player
  def create
    waiting_room = WaitingRoomService.open_back_end_waiting_room(current_player.email, params[:username])
    if waiting_room
      redirect_to waiting_room_path
    else
      render :new
    end
  end

  def join_game
  end

  def create_waiting_room_player
    waiting_room = WaitingRoomService.join_back_end_waiting_room(
      current_player.email,
      params[:username],
      params[:room_code]
      )
    if waiting_room
      redirect_to waiting_room_path
    else
      redirect_to join_game_path
    end
  end
end
