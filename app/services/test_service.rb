class TestService < ApplicationController
  extend Connection

  def self.clean_be_database
    conn = connect
    conn.delete("/api/v1/test/database_all")
  end
end
