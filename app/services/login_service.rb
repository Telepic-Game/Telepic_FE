class LoginService
  extend Connection

  def self.user_login(input)
    conn = connect
    response = conn.post('/api/v1/login') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = input.to_json
    end
    user_data = JSON.parse(response.body, symbolize_names: true)
    if !user_data[:data]
      return false
    elsif user_data[:data]
      return true
    end
  end
end
