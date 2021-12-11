require 'rails_helper'

RSpec.describe "As a player", type: :feature do
  before :each do
    host = Player.create(
      {
        email: "elonsmusk@gmail.com",
        # password: "1234test"
        permissions: "registered"
      }
    )
    @player = Player.find_by(email: "elonsmusk@gmail.com")
  end

  after :each do
    Game.destroy_all
    WaitingRoomPlayer.destroy_all
    WaitingRoom.destroy_all
    Player.destroy_all
  end

  describe "Happy Path" do
    it "Registered Player should be able to create waiting room" do
      #Registered Player permission field changes from 0
      # 0 - Guest, 1 - Registered, 2 - Host, 3 - Admin
      # Waiting Room Player & Waiting Room are created in BE

      allow_any_instance_of(ApplicationController).to receive(:current_player).and_return(@player)
      visit login_root_path

      within("#login_buttons") do
        expect(page).to have_button("Log Out")
        expect(page).to have_button("Join Game")
        expect(page).to have_button("Create Waiting Room")
      end

      expect(page).to have_content("Welcome to Telepic, #{@player.email}")

      click_button("Create Waiting Room")

      expect(current_path).to eq(new_waiting_room_path)
      expect(page).to have_content("Choose your Telepic username for this game!")
      expect(page).to have_field("Enter username!")
      expect(page).to have_field(:username)
      fill_in "Enter username!", with: "elonsmusk"
      click_button("Open Waiting Room")

      expect(current_path).to eq(waiting_room_path)
      save_and_open_page
      expect(page).to have_content("Waiting Room")
      expect(page).to have_content("Username: elonsmusk")
      expect(page).to have_content("Players in Room")
      expect(page).to have_content("You can send invites with your room code number:")
      expect(page).to have_button("Start Game")
    end
  end
end
