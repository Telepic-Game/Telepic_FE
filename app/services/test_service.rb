class TestService < ApplicationController
  extend Connection

  def self.clean_be_user_database(email)
    conn = connect
    conn.delete("/api/v1/register/#{email}")
  end
end
