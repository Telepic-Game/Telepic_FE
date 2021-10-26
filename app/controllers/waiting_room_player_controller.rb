class WaitingRoomPlayerController < ApplicationController
  def index
  end

  def new
  end

  def create
    if current_player.nil?
      player = Player.new(
        {
          email: "guest",
          permissions: "guest",
          username: params[:username]
        }
      )
      if player.save
        session[:player_id] = player.id
        flash[:success] = "Congratulations, you have joined a waiting room as a Guest!"
        player.save
      end
      waiting_room = WaitingRoom.find_by(room_code: params[:room_code])
      player = Player.find(current_player.id)
      waiting_room_player = WaitingRoomPlayer.new(
        {
          waiting_room_id: waiting_room.id,
          player_id: player.id,
          username: params[:username],
          room_code: waiting_room.room_code
        }
      )
      if waiting_room_player.save
        redirect_to waiting_room_path
      end
    end
  end
end
