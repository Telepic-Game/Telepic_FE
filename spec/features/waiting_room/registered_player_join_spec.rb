require 'rails_helper'

RSpec.describe "As a player", type: :feature do
  before :each do
    Player.destroy_all
    TestService.clean_be_database
    data_1 = RegistrationService.register_player(
      {
        email: "elonsmusk@gmail.com",
        verify_email: "elonsmusk@gmail.com",
        password: "1234test",
        password_confirmation: "1234test",
      }
    )
    Player.create(
      email: data_1[:email],
      be_id: data_1[:be_id],
    )
    @player_1 = Player.find_by(email: "elonsmusk@gmail.com")

    WaitingRoomService.open_back_end_waiting_room(@player_1.email, "elonsmusk")

    @waiting_room_1 = WaitingRoomService.get_back_end_waiting_room(@player_1.email)

    data_2 = RegistrationService.register_player(
      {
        email: "taoistcowboy@gmail.com",
        verify_email: "taoistcowboy@gmail.com",
        password: "1234test",
        password_confirmation: "1234test",
      }
    )
    Player.create(
      email: data_2[:email],
      be_id: data_2[:be_id],
    )
    @player_2 = Player.find_by(email: "taoistcowboy@gmail.com")
  end

  after :each do
    Player.destroy_all
    TestService.clean_be_database
  end

  describe "Happy Path" do
    it "Registered Player should be able to join waiting room" do
      #Registered Player permission field changes from 0
      # 0 - Guest, 1 - Registered, 2 - Host, 3 - Admin
      # Waiting Room Player & Waiting Room are created in BE

      allow_any_instance_of(ApplicationController).to receive(:current_player).and_return(@player_2)

      visit login_root_path

      click_button "Join Game"

      expect(current_path).to eq(join_game_path)
      expect(page).to have_content("Welcome to Telepic!")
      expect(page).to have_field(:username)
      expect(page).to have_field("Enter username")
      expect(page).to have_field(:room_code)
      expect(page).to have_field("Enter Room Code")
      expect(page).to have_button("Join Waiting Room")

      fill_in :username, with: "taoistcowboy"
      # require "pry"; binding.pry
      fill_in :room_code, with: "#{@waiting_room_1[:data][:attributes][:waiting_room][:room_code]}"

      click_button "Join Waiting Room"
      save_and_open_page

      expect(current_path).to eq(waiting_room_path)
      expect(page).to have_content("Waiting Room")
      expect(page).to have_content("Username: taoistcowboy")
      expect(page).to have_content("taoistcowboy")
      expect(page).to have_content("elonsmusk")
      expect(page).to have_content("Players in Room")
      expect(page).to have_content("You can send invites with your room code number: #{@waiting_room_1[:data][:attributes][:waiting_room][:room_code]}")
      expect(page).to have_button("Start Game")
    end
  end
end
