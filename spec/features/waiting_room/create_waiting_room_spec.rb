require 'rails_helper'

RSpec.describe "As a player", type: :feature do
  before :each do
    Player.destroy_all
    TestService.clean_be_player_database
    data = RegistrationService.register_player(
      {
        email: "elonsmusk@gmail.com",
        verify_email: "elonsmusk@gmail.com",
        password: "1234test",
        password_confirmation: "1234test",
      }
    )
    Player.create(
      email: data[:email],
      be_id: data[:be_id],
    )
    @player = Player.find_by(email: "elonsmusk@gmail.com")
  end

  after :each do
    Player.destroy_all
    TestService.clean_be_player_database
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

      expect(page).to have_content(@player.email)

    end
  end
end
