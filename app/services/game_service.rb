class GameService
  extend Connection

  def self.start_game(email)
    conn = connect
    response = conn.patch('/api/v1/start_game') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params[:email] = email
    end
    game_data = JSON.parse(response.body, symbolize_names: true)
    if !game[:data]
      return { "response": false }
    elsif game[:data]
      return { "response": true, "data": game[:data] }
    else
      return { "response": "Unexpected Error"}
    end
  end
end
