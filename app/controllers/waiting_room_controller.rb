class WaitingRoomController < ApplicationController
  def index
    # if current_player.email.nil?
      # waitingroomservice.getbackendwaitingroom(current_player.username)
    # else

    @waiting_room = WaitingRoomService.get_back_end_waiting_room(current_player.email)
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
    current_player ? email = current_player.email : email = nil
    waiting_room = WaitingRoomService.join_back_end_waiting_room(
      email,
      params[:username],
      params[:room_code]
      )
    # from response, if permissions are 0. maybe create player on FE & session
    if waiting_room
      redirect_to waiting_room_path
    else
      redirect_to join_game_path
    end
  end
end
