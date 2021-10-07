require 'rails_helper'

RSpec.describe "As a player", type: :feature do
  before :each do
    player = RegistrationService.register_player(
      {
        email: "elonsmusk@gmail.com",
        verify_email: "elonsmusk@gmail.com",
        password: "1234test",
        password_confirmation: "1234test",
      }
    )
    Player.create(
      email: player[:email],
      be_id: player[:be_id],
    )
  end

  after :each do
    Player.destroy_all
    TestService.clean_be_database
  end

  describe "Happy Path" do
    it "Player should be able to log out" do
      visit '/login'
      fill_in :email, with: "elonsmusk@gmail.com"
      fill_in :password, with: "1234test"
      click_button "Login!"
      within "#logout_button" do
        expect(page).to have_button("Logout")
        click_button "Logout"
      end
      expect(current_path).to eq(root_path)
      expect(page).not_to have_button("Logout")
    end
  end
end
