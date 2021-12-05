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

      expect(current_path).to eq(waiting_room_path)
    end
  end
end
