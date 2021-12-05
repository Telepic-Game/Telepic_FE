require 'rails_helper'

RSpec.describe "Waiting Room - Hotwire Tests", type: :feature do
  after :all do
    WaitingRoom.destroy_all
    WaitingRoomPlayer.destroy_all
    Player.destroy_all
  end
  describe "Hotwire works as expected" do
    it "Guest can open waiting room" do
      visit root_path
      click_button "Start Waiting Room as a Guest"
      fill_in :username, with: "Jordan Beck"
      click_button "Open Waiting Room"

      expect(page.first('div#waiting_room_player').text).to eq('Jordan Beck')
      expect(current_path).to eq(waiting_room_path)

      room_code = WaitingRoom.first.room_code

      visit root_path
      click_button "Join Game"
      fill_in :username, with: "Kris Litman"
      fill_in :room_code, with: room_code
      click_button "Join Waiting Room"

      # Continue Here!
    end
  end
end
