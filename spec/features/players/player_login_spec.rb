require 'rails_helper'

RSpec.describe "As a player", type: :feature do
  before :each do
    player = Player.create(
      {
        email: "elonsmusk@gmail.com",
        password: "1234test"
      }
    )
  end

  after :each do
    Player.destroy_all
  end

  describe "Happy Path" do
    it "Player should be able to log in" do
      visit '/login'

      within "#login_form" do
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
        expect(page).to have_button("Login!")

        fill_in :email, with: "elonsmusk@gmail.com"
        fill_in :password, with: "1234test"

        click_button "Login!"
      end
      expect(current_path).to eq(login_root_path)
      expect(page).to have_content("You have been logged in successfully!")
    end
  end

#   describe "Sad Path" do
#     it "Player cant log in without an email" do
#       visit '/login'
#
#       within "#login_form" do
#         expect(page).to have_field(:email)
#         expect(page).to have_field(:password)
#         expect(page).to have_button("Login!")
#
#         fill_in :email, with: ""
#         fill_in :password, with: "1234test"
#
#         click_button "Login!"
#       end
#       expect(current_path).to eq('/login')
#       expect(page).to have_content("Invalid email or password")
#     end
#
#     it "Player cant log in without a password" do
#       visit '/login'
#
#       within "#login_form" do
#         expect(page).to have_field(:email)
#         expect(page).to have_field(:password)
#         expect(page).to have_button("Login!")
#
#         fill_in :email, with: "elonsmusk@gmail.com"
#         fill_in :password, with: ""
#
#         click_button "Login!"
#       end
#       expect(current_path).to eq('/login')
#       expect(page).to have_content("Invalid email or password")
#     end
#   end
end
