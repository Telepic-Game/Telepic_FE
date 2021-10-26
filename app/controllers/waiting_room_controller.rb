class WaitingRoomController < ApplicationController
  def index
    current_user = Player.where(id: current_player.waiting_room_player.player_id)
    @username = current_user.last.username
    @room_code = current_player.waiting_room.room_code
    @all_players = current_player.waiting_room.players
    # @waiting_room =
    #  WaitingRoomService.get_back_end_waiting_room(current_player.email)
    # # Need to grab game from backend for statusp
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
    if current_player.nil?
      player = Player.new(
        {
          email: "guest",
          permissions: "guest"
        }
      )
      if player.save
        session[:player_id] = player.id
        flash[:success] = "Congratulations, you have created a waiting room as a new Guest!"
        player.save
        redirect_to new_waiting_room_path
      end
    end
  end

  def create
    current_player.permissions = "host"
    current_player[:username] = params[:username]
    waiting_room = WaitingRoom.new
    # require "pry"; binding.pry
    if waiting_room.save
      # current_player.permissions = 'host'
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
  #   require "pry"; binding.pry
  #   waiting_room_player ||= WaitingRoomPlayer.new(
  #     waiting_room_id: params[:room_code],
  #     player_id: Player.where(id: current_player.waiting_room_player.player_id).last.id,
  #     username: params[:username]
  #   )
  #   if waiting_room_player.save
  #     redirect_to waiting_room_path
  #   end
  # end
end
