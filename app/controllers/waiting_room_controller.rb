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
    @game = (Game.where(id: @game_id.to_i)).first
    @game_status = false
    @expected_player_count = "#{ current_player.waiting_room.player_count } Player Game"
    @epc = current_player.waiting_room.player_count
    @ready_up_counter = 0
  end

  # def create_stacks_and_cards
  #   @waiting_room_players.map { |player| Stack.create(cards: (@epc * 2) times do Card.create ) = @epc }
  # end

  def game_active
    @game.game_active
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
        # require "pry"; binding.pry
        flash[:success] = "Congratulations, you have created a waiting room as a new Guest!"
        player.save
        redirect_to new_waiting_room_path
      end
    end
  end

  def update
    @ready_up_counter = @ready_up_counter + 1
    require "pry"; binding.pry
  end

  def create
    current_player.permissions = "host"
    current_player[:username] = params[:username]
    waiting_room = WaitingRoom.new
    waiting_room[:player_count] = params[:player_count].to_i
    # require "pry"; binding.pry
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
