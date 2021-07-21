require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
    RegistrationService.register_user(
      {
        email: "elonsmusk@gmail.com",
        verify_email: "elonsmusk@gmail.com",
        password: "1234test",
        password_confirmation: "1234test",
      }
    )
  end

  after :each do
    User.destroy_all
    TestService.clean_be_user_database
  end

  describe "Happy Path" do
    it "User should be able to log in" do
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

  describe "Sad Path" do
    it "User cant log in without an email" do
      visit '/login'

      within "#login_form" do
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
        expect(page).to have_button("Login!")

        fill_in :email, with: ""
        fill_in :password, with: "1234test"

        click_button "Login!"
      end
      expect(current_path).to eq('/login')
      expect(page).to have_content("Invalid email or password")
    end

    it "User cant log in without a password" do
      visit '/login'

      within "#login_form" do
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
        expect(page).to have_button("Login!")

        fill_in :email, with: "elonsmusk@gmail.com"
        fill_in :password, with: ""

        click_button "Login!"
      end
      expect(current_path).to eq('/login')
      expect(page).to have_content("Invalid email or password")
    end
  end
end
