class WaitingRoomController < ApplicationController
  def index
    @waiting_room = WaitingRoomService.get_back_end_waiting_room(current_player.email)
    @username = @waiting_room[:data][:attributes][:player][:username]
    @room_code = @waiting_room[:data][:attributes][:waiting_room][:room_code]
  end

  def new
  end

  def create
    waiting_room = WaitingRoomService.open_back_end_waiting_room(current_player.email, params[:username])
    if waiting_room
      redirect_to waiting_room_path
    else
      render :new
    end
  end
end
