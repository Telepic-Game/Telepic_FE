require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  before :each do
    User.destroy_all
    TestService.clean_be_user_database
    data = RegistrationService.register_user(
      {
        email: "elonsmusk@gmail.com",
        verify_email: "elonsmusk@gmail.com",
        password: "1234test",
        password_confirmation: "1234test",
      }
    )
    User.create(
      email: data[:email],
      be_id: data[:be_id],
    )
    @user = User.find_by(email: "elonsmusk@gmail.com")
  end

  after :each do
    User.destroy_all
    TestService.clean_be_user_database
  end

  describe "Happy Path" do
    it "Registered User should be able to create waiting room" do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit login_root_path

      within("#login_buttons")

      expect(page).to have_content(@user.email)

    end
  end
end
