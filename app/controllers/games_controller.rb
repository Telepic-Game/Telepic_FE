class GamesController < ApplicationController
  def start
    response = GameService.start_game(
      current_player.email,
      params[:waiting_room_code]
    )
    #Each player that was in game, create their stack and cards
    rounds = response.dig(:data, :attributes, :game, :turn_counter)

    new_response = response.dig(:data, :attributes, :game_players)

    unless new_response.nil?
      new_response.map do |player|
        p = Player.find_by(be_id: player[:id])
        s = Stack.create(player_id: p.id)
        rounds.times do
          s.cards.create
        end
      end
    end 
    #redirect_to rounds_path
    #Use Hotwire
  end
end
