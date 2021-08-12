require 'rails_helper'

RSpec.describe "When a new game is created", type: :feature do
  before :each do
    Player.destroy_all
    TestService.clean_be_database
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
      permissions: 'host',
    )
    @player = Player.find_by(email: "elonsmusk@gmail.com")
    @waiting_room = WaitingRoomService.open_back_end_waiting_room(
      @player.email,
      'elonsmusk',
    )
    @roomcode = @waiting_room.dig(:data, :attributes, :waiting_room, :room_code)
    data_2 = RegistrationService.register_player(
      {
        email: "taoistcowboy@gmail.com",
        verify_email: "taoistcowboy@gmail.com",
        password: "12345",
        password_confirmation: "12345",
      }
    )
    Player.create(
      email: data_2[:email],
      be_id: data_2[:be_id],
      permissions: 'registered',
    )
    @player_2 = Player.find_by(email: "taoistcowboy@gmail.com")
    WaitingRoomService.join_back_end_waiting_room(
      @player_2.email,
      'taoistcowboy',
      @roomcode,
    )
    WaitingRoomService.join_back_end_waiting_room(
      nil,
      'apollo',
      @roomcode,
    )
  end

  after :each do
    Player.destroy_all
    TestService.clean_be_database
  end

  describe "Happy Path" do
    it "Host clicks ~Start Game~ and sees round 1 page" do
      allow_any_instance_of(ApplicationController).to receive(:current_player).and_return(@player)
      visit waiting_room_path

      click_button('Start Game')
      expect(current_path).to eq(start_game_path)
    end
  end
end
