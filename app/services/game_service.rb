class GameService
  extend Connection

  def self.start_game(email, room_code)
    conn = connect
    response = conn.patch('/api/v1/start_game') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params[:email] = email
      req.params[:room_code] = room_code
    end
    game_data = JSON.parse(response.body, symbolize_names: true)
    if !game_data[:data]
      return { "response": false }
    elsif game_data[:data]
      return { "response": true, "data": game_data[:data] }
    else
      return { "response": "Unexpected Error"}
    end
  end
end
