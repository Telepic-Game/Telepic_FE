require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  scenario "I can register as a new user" do
    visit '/'

    expect(current_path).to eq('/')
    expect(page).to have_button('Login')
    expect(page).to have_button('Register')
    expect(page).to have_button('Join Game')
  end
end
