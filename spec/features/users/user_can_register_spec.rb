require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
    User.destroy_all
    TestService.clean_be_user_database
  end

  scenario "I can register as a new user" do
    visit '/'

    expect(current_path).to eq('/')
    within('#index_btn') do
      expect(page).to have_button('Login')
      expect(page).to have_button('Register')
      expect(page).to have_button('Join Game')
      click_button('Register')
    end
    expect(current_path).to eq('/register')
    expect(page).to have_content('Register')
    expect(page).to have_content('Register for Telepic!')
    within('#register_form') do
      expect(page).to have_field(:email)
      expect(page).to have_field(:verify_email)
      expect(page).to have_field(:password)
      expect(page).to have_field(:password_confirmation)
      expect(page).to have_button('Submit Registration!')

      fill_in :email, with: 'example@example.com'
      fill_in :verify_email, with: 'example@example.com'
      fill_in :password, with: '1234'
      fill_in :password_confirmation, with: '1234'

      click_button('Submit Registration!')
    end
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Congratulations, you have successfully registered and are now logged in!")
  end

  describe "Sad Path" do
    it "User doesnt get registered with blank email" do
      visit '/register'

      within('#register_form') do
        fill_in :email, with: ''
        fill_in :verify_email, with: ''
        fill_in :password, with: '1234'
        fill_in :password_confirmation, with: '1234'

        click_button('Submit Registration!')
      end
      expect(current_path).to eq('/register')
      expect(page).to have_content("There was a problem registering you. Please try again.")
    end

    it "User doesnt get registered with empty password & confirmation" do
      visit '/register'

      within('#register_form') do
        fill_in :email, with: 'example@example.com'
        fill_in :verify_email, with: 'example@example.com'
        fill_in :password, with: ''
        fill_in :password_confirmation, with: ''

        click_button('Submit Registration!')
      end
      expect(current_path).to eq('/register')
      expect(page).to have_content("There was a problem registering you. Please try again.")
    end
  end
end
