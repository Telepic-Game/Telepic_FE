class TestService < ApplicationController
  extend Connection

  def self.clean_be_player_database
    conn = connect
    conn.delete("/api/v1/test/players_all")
  end
end
