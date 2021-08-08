class WaitingRoomService
  extend Connection

  def self.open_back_end_waiting_room(email, username)
    conn = connect
    response = conn.post('/api/v1/open_waiting_room') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params[:email] = email
      req.params[:username] = username
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

  def self.get_back_end_waiting_room(email)
    conn = connect
    response = conn.get('/api/v1/waiting_room') do |req|
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

  def self.join_back_end_waiting_room(email, username, room_code)
    conn = connect
    response = conn.post('/api/v1/non_host_join_waiting_room') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params[:email] = email
      req.params[:username] = username
      req.params[:room_code] = room_code
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
