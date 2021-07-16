class RegistrationService
  extend Connection

  def self.register_user(input)
    conn = connect
    response = conn.post('/api/v1/register') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = input.to_json
    end
    user_data = JSON.parse(response.body, symbolize_names: true)
    User.create(
      email: user_data[:data][:attributes][:email],
      be_id: user_data[:data][:id]
    )
  end
end
