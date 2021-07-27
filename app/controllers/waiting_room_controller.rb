class WaitingRoomController < ApplicationController
  def index
  end

  def new
  end

  def create
    waiting_room = WaitingRoomService.open_back_end_waiting_room(current_player.email)
    if waiting_room
      redirect_to waiting_room_path
    else
      render :new
    end
  end
end
