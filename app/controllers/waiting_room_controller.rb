class WaitingRoomController < ApplicationController
  def index
    @current_user_id = current_player.id
    @username = current_player.username
    @all_players = current_player.waiting_room.players.map do |player|
                     player.username
                   end.uniq
    @room_code = current_player.room_code
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
end
