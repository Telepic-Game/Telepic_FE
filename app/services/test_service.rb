class TestService < ApplicationController
  extend Connection

  def self.clean_be_user_database
    conn = connect
    # conn.delete("/api/v1/register/#{email}")
    conn.delete("/api/v1/test/users_all")
  end
end
