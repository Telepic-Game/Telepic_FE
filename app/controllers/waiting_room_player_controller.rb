class WaitingRoomPlayerController < ApplicationController
  def index
  end

  def new
  end

  def create
    current_player = Player.new(
      {
        email: "guest",
        created_at: params[:created_at],
        updated_at: params[:updated_at],
        permissions: "guest",
        username: params[:username],
        room_code: params[:room_code]
      }
    )
    if current_player.save
      session[:player_id] = current_player.id
      flash[:success] = "Congratulations, you have joined a waiting room as a Guest!"
      current_player.save
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
    else
      redirect_to root_path
    end
  end
end
