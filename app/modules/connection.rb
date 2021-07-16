module Connection

  def connect
    if (Rails.env.development? || Rails.env.test?)
      Faraday.new(Figaro.env.local_connection)
    elsif Rails.env.production?
      Faraday.new(Figaro.env.prod_connection)
    end
  end
end
