class WaitingRoomController < ApplicationController
  def index
    @current_user_id = current_player.id
    @username = current_player.username
    @all_players = current_player.waiting_room.players.map do |player|
                     player.username
                   end.uniq
    @room_code = current_player.room_code
    @waiting_room_players = current_player.waiting_room.waiting_room_players
    @waiting_room_player = WaitingRoomPlayer.new
    # @game_players = WaitingRoomPlayer.where(waiting_room_id: current_player.waiting_room_id)
    @game_id = current_player.game_id
    @game = Game.where(id: @game_id.to_i)
    @game_status = @game.first.game_active
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
    if waiting_room.save
      game = Game.create(waiting_room_id: "#{waiting_room.id}", game_players:
               {
                 "data": [
                   {
                     "game_players": [current_player],
                   }
                 ]
               }
             )
     # game.game_players.dig("data")[0].dig("game_players")[0].dig("id")
             # require "pry"; binding.pry
      # game.players.push(current_player)
      current_player.game_id = game.id
      current_player.room_code = waiting_room.room_code
      current_player.waiting_room_id = waiting_room.id
      # current_player.permissions = 'host'
      current_player.save
      @waiting_room_player = WaitingRoomPlayer.new(
        waiting_room_id: waiting_room.id,
        player_id: current_player.id,
        username: params[:username]
      )
      if @waiting_room_player.save
        respond_to do |format|
          if waiting_room.save
            format.html { redirect_to waiting_room_url, notice: 'Guest has been added.' }
            format.json { render :show, status: :created, location: @waiting_room_player }
          end
        end
        # redirect_to waiting_room_path
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
