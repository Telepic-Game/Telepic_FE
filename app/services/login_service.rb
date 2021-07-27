class LoginService
  extend Connection

  def self.player_login(input)
    conn = connect
    response = conn.post('/api/v1/login') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = input.to_json
    end
    player_data = JSON.parse(response.body, symbolize_names: true)
    if !player_data[:data]
      return false
    elsif player_data[:data]
      return true
    end
  end
end
