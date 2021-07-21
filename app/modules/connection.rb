module Connection

  def connect
    if Rails.env.test?
      Faraday.new(Figaro.env.local_connection)
    elsif Rails.env.development?
      Faraday.new(Figaro.env.local_connection)
    elsif Rails.env.production?
      Faraday.new(Figaro.env.prod_connection)
    end
  end
end
