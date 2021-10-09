class WaitingRoomController < ApplicationController
  def index
# require "pry"; binding.pry
    @username = current_player.waiting_room_player.username
    # @waiting_room =
    #  WaitingRoomService.get_back_end_waiting_room(current_player.email)
    # # Need to grab game from backend for status
    # @game = @waiting_room.dig(:data, :attributes, :game)
    # if @game[:active] == false
    #   @username = @waiting_room[:data][:attributes][:player]  [:current_player][:username]
    #   @room_code = @waiting_room[:data][:attributes][:waiting_room] [:room_code]
    #   @all_players = @waiting_room[:data][:attributes][:player] [:all_players]
    # elsif @game[:active] == true
    #   redirect_to start_game_path
    # end
  end

  def new
  end

  def create
    waiting_room = WaitingRoom.new
    if waiting_room.save
      current_player.permissions = 'host'
      current_player.save
      waiting_room_player = WaitingRoomPlayer.new(
        waiting_room_id: waiting_room.id,
        player_id: current_player.id,
        username: params[:username]
      )
      if waiting_room_player.save
        redirect_to waiting_room_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def join_game
  end

  # def create_waiting_room_player
  #   current_player ? email = current_player.email : email = nil
  #   response = WaitingRoomService.join_back_end_waiting_room(
  #     email,
  #     params[:username],
  #     params[:room_code]
  #     )
  #   # from response, if permissions are 0. maybe create player on FE & session
  #   if response[:data][:attributes][:player][:permissions] == 'guest'
  #     guest = Player.create(
  #       email: response[:data][:attributes][:player][:player_username],
  #       be_id: response[:data][:attributes][:player][:id]
  #     )
  #     session[:player_id] = guest.id
  #     current_player.permissions = 'guest'
  #     current_player.save
  #     redirect_to waiting_room_path
  #   elsif response[:data][:attributes][:player][:permissions] == 'registered'
  #     current_player.permissions = 'registered'
  #     current_player.save
  #     redirect_to waiting_room_path
  #   else
  #     redirect_to join_game_path
  #   end
  # end
end
