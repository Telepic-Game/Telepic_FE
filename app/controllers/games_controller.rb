class GamesController < ApplicationController
  def start
    require "pry"; binding.pry
    @game_players = WaitingRoomPlayer.where(waiting_room_id: current_player.waiting_room_id)

    if @game_players.count == 3
      stacks = {
        Stack.create(@game_players[0]),
        Stack.create(@game_players[1]),
        Stack.create(@game_players[2])
      }
      Game.create(stacks)
    elsif @game_players.count == 4
      stacks = {
        Stack.create(@game_players[0]),
        Stack.create(@game_players[1]),
        Stack.create(@game_players[2]),
        Stack.create(@game_players[3])
      }
      Game.create(stacks)
    elsif @game_players.count == 5
      stacks = {
        Stack.create(@game_players[0]),
        Stack.create(@game_players[1]),
        Stack.create(@game_players[2]),
        Stack.create(@game_players[3]),
        Stack.create(@game_players[4])
      }
      Game.create(stacks)
    elsif @game_players.count == 6
      stacks = {
        Stack.create(@game_players[0]),
        Stack.create(@game_players[1]),
        Stack.create(@game_players[2]),
        Stack.create(@game_players[3]),
        Stack.create(@game_players[4]),
        Stack.create(@game_players[5])
      }
      Game.create(stacks)
    elsif @game_players.count == 7
      stacks = {
        Stack.create(@game_players[0]),
        Stack.create(@game_players[1]),
        Stack.create(@game_players[2]),
        Stack.create(@game_players[3]),
        Stack.create(@game_players[4]),
        Stack.create(@game_players[5]),
        Stack.create(@game_players[6])
      }
      Game.create(stacks)
    else @game_players.count == 8
      stacks = {
        Stack.create(@game_players[0]),
        Stack.create(@game_players[1]),
        Stack.create(@game_players[2]),
        Stack.create(@game_players[3]),
        Stack.create(@game_players[4]),
        Stack.create(@game_players[5]),
        Stack.create(@game_players[6]),
        Stack.create(@game_players[7])
      }
      Game.create(stacks)
    end


    #each member in @game_players needs to be assigned a stack with cards equal to players in game. Might be easiest to make guard statements for 3,4,5,6,7,8 people seperately. then make it dynamic later.
    #seperate model for stack, and card, still  needed 
    #each card should be labeled with the round number, current players username, and also include a short few words of instruction


    # waiting_room = WaitingRoom.find(id: )

    #get rid of service, create game model?

  # response = GameService.start_game(
    #   current_player.email,
    #   params[:waiting_room_code]
    # )
    # #Each player that was in game, create their stack and cards
    # rounds = response.dig(:data, :attributes, :game, :turn_counter)
    #
    # new_response = response.dig(:data, :attributes, :game_players)
    #
    # unless new_response.nil?
    #   new_response.map do |player|
    #     p = Player.find_by(be_id: player[:id])
    #     s = Stack.create(player_id: p.id)
      #   rounds.times do
      #     s.cards.create
      #   end
      # end
    # end
    #redirect_to rounds_path
    #Use Hotwire
  end
end
