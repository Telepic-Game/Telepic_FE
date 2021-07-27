class RegistrationService
  extend Connection

  def self.register_player(input)
    conn = connect
    response = conn.post('/api/v1/register') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = input.to_json
    end
    player_data = JSON.parse(response.body, symbolize_names: true)
    if !player_data[:data]
      return { "response": false }
    elsif player_data[:data]
      return { "response": true,
               "be_id": player_data[:data][:id],
               "email": player_data[:data][:attributes][:email] }
    end
  end
end
