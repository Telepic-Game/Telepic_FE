class RegistrationService

  def self.register_user(input)
    conn = local_conn
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

  def self.destroy_user(email)
    conn = local_conn
    conn.delete("/api/v1/register/#{email}")
  end

  private

  def self.local_conn
    Faraday.new('http://localhost:3001')
  end
end
