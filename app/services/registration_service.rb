class RegistrationService

  def self.register_user(input)
    conn = local_conn
    response = conn.post('/api/v1/register') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = input.to_json
    end
    user_date = JSON.parse(response.body, symbolize_names: true)
    User.create(
      email: user_date[:email],
    )
    require 'pry'; binding.pry
  end

  private

  def self.local_conn
    Faraday.new('http://localhost:3001')
  end
end
