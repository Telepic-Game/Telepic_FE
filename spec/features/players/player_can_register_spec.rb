require 'rails_helper'

RSpec.describe "As a player", type: :feature do
  before :each do
    Player.destroy_all
    # TestService.clean_be_database
  end

  scenario "I can register as a new player" do
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
      fill_in :password, with: '!1234Abc'
      fill_in :password_confirmation, with: '!1234Abc'

      click_button('Submit Registration!')
    end

    expect(current_path).to eq(login_root_path)
    expect(page).to have_content("Congratulations, you have successfully registered and are now logged in!")
  end

  # describe "Sad Path" do
  #   it "Player doesnt get registered with blank email" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: ''
  #       fill_in :verify_email, with: ''
  #       fill_in :password, with: '!1234Abc'
  #       fill_in :password_confirmation, with: '!1234Abc'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player doesnt get registered with empty password & confirmation" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: ''
  #       fill_in :password_confirmation, with: ''
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player doesnt get registered with empty password" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: ''
  #       fill_in :password_confirmation, with: ';aldskjfafldksafj'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player doesnt get registered with empty password confirmation" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!1234Abc'
  #       fill_in :password_confirmation, with: ''
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  # end
  #
  # describe "Strong Password Testing" do
  #   it "Player cannot register with weak password" do
  #     # string contains at least a lowercase letter, a uppercase, a digit, a special char and 8+ chars
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '1234'
  #       fill_in :password_confirmation, with: '1234'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with weak password and special character" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!1234'
  #       fill_in :password_confirmation, with: '!1234'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with strong password that has no lower case" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!1234AAA'
  #       fill_in :password_confirmation, with: '!1234AAA'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with strong password and no specal symbol" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '1234Abcc'
  #       fill_in :password_confirmation, with: '1234Abcc'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with strong password and no number" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!Abccccc'
  #       fill_in :password_confirmation, with: '!Abccccc'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with all special characters password" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!!!!!!!!'
  #       fill_in :password_confirmation, with: '!!!!!!!!'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with weak password of all numbers" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '11111111'
  #       fill_in :password_confirmation, with: '11111111'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with weak password of all lowercase" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: 'aaaaaaaa'
  #       fill_in :password_confirmation, with: 'aaaaaaaa'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with weak password of all upcase" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: 'AAAAAAAA'
  #       fill_in :password_confirmation, with: 'AAAAAAAA'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   it "Player cannot register with strong password of less than 8 characters" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!1234Ab'
  #       fill_in :password_confirmation, with: '!1234Ab'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  #
  #   skip it "Player cannot register with strong password of more than 16 characters" do
  #     visit '/register'
  #
  #     within('#register_form') do
  #       fill_in :email, with: 'example@example.com'
  #       fill_in :verify_email, with: 'example@example.com'
  #       fill_in :password, with: '!1234Abt56%Tt45#e'
  #       fill_in :password_confirmation, with: '!1234Abt56%Tt45#e'
  #
  #       click_button('Submit Registration!')
  #     end
  #     expect(current_path).to eq('/register')
  #     expect(page).to have_content("There was a problem registering you. Please try again.")
  #   end
  # end
end
