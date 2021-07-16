require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
    User.destroy_all
    TestService.clean_be_user_database('example@example.com')
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
end
