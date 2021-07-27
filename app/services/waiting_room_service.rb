class WaitingRoomService
  extend Connection

  def self.open_back_end_waiting_room(email)
    conn = connect
    response = conn.post('/api/v1/open_waiting_room') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params[:email] = email
    end
    wr_data = JSON.parse(response.body, symbolize_names: true)
    if !wr_data[:data]
      return { "response": false }
    elsif wr_data[:data]
      return { "response": true, "data": wr_data[:data] }
    else
      return { "response": "Unexpected Error"}
    end
  end
end