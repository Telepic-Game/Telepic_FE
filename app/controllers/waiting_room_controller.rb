class WaitingRoomController < ApplicationController
  def index
    @waiting_room = WaitingRoomService.get_back_end_waiting_room(current_player.email)
    # Need to grab game from backend for status
    @game = @waiting_room.dig(:data, :attributes, :game)
    require "pry"; binding.pry
    if @game[:active] == false
      @username = @waiting_room[:data][:attributes][:player]  [:current_player][:username]
      @room_code = @waiting_room[:data][:attributes][:waiting_room] [:room_code]
      @all_players = @waiting_room[:data][:attributes][:player] [:all_players]
    elsif @game[:active] == true
      # redirect_to game_start_path
    end
  end

  def new
  end

  def create
    # Create waiting room and host player
    waiting_room = WaitingRoomService.open_back_end_waiting_room(current_player.email, params[:username])
    # Add permissions to the player
    if waiting_room
      current_player.permissions = 'host'
      redirect_to waiting_room_path
    else
      render :new
    end
  end

  def join_game
  end

  def create_waiting_room_player
    current_player ? email = current_player.email : email = nil
    response = WaitingRoomService.join_back_end_waiting_room(
      email,
      params[:username],
      params[:room_code]
      )
    # from response, if permissions are 0. maybe create player on FE & session
    if response[:data][:attributes][:player][:permissions] == 'guest'
      guest = Player.create(
        email: response[:data][:attributes][:player][:player_username],
        be_id: response[:data][:attributes][:player][:id]
      )
      session[:player_id] = guest.id
      current_player.permissions = 'guest'
      redirect_to waiting_room_path
    elsif response[:data][:attributes][:player][:permissions] == 'registered'
      current_player.permissions = 'registered'
      redirect_to waiting_room_path
    else
      redirect_to join_game_path
    end
  end
end
