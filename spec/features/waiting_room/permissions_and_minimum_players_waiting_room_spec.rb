require 'rails_helper'

# RSpec.describe "As the host", type: :feature do
#   before :each do
#     Player.destroy_all
#     TestService.clean_be_database
#     data_1 = RegistrationService.register_player(
#       {
#           email: "elonsmusk@gmail.com",
#           verify_email: "elonsmusk@gmail.com",
#           password: "1234test",
#           password_confirmation: "1234test",
#         }
#       )
#     Player.create(
#       email: data_1[:email],
#       be_id: data_1[:be_id],
#       permissions: 'host',
#     )
#     @player_1 = Player.find_by(email: "elonsmusk@gmail.com")
#     WaitingRoomService.open_back_end_waiting_room(@player_1.email, "elonsmusk")
#     @waiting_room_1 = WaitingRoomService.get_back_end_waiting_room(@player_1.email)
#     data_2 = RegistrationService.register_player(
#       {
#         email: "taoistcowboy@gmail.com",
#         verify_email: "taoistcowboy@gmail.com",
#         password: "1234test",
#         password_confirmation: "1234test",
#       }
#     )
#     Player.create(
#       email: data_2[:email],
#       be_id: data_2[:be_id],
#       permissions: 'registered',
#     )
#     @player_2 = Player.find_by(email: "taoistcowboy@gmail.com")
#     WaitingRoomService.join_back_end_waiting_room(
#       @player_2.email,
#       'taoistcowboy',
#       @waiting_room_1[:data][:attributes][:waiting_room][:room_code],
#     )
#     guest = WaitingRoomService.join_back_end_waiting_room(
#       nil,
#       'eros',
#       @waiting_room_1[:data][:attributes][:waiting_room][:room_code],
#     )
#     # require "pry"; binding.pry
#     Player.create(
#       email: guest[:data][:attributes][:player][:player_username],
#       be_id: guest[:data][:attributes][:player][:id],
#       permissions: 'guest',
#     )
#     @player_3 = Player.find_by(email: 'eros')
#   end

#   describe 'Happy Path' do
#     it 'See a button to start game, a registered player, and a guest player as host' do
#       allow_any_instance_of(ApplicationController).to receive(:current_player).and_return(@player_1)

#       visit waiting_room_path

#       expect(page).to have_button('Start Game')
#       expect(page).to have_content('elonsmusk')
#       expect(page).to have_content('taoistcowboy')
#       expect(page).to have_content('eros')
#     end
#     it 'See a registered player, and a guest player as taoist' do
#       allow_any_instance_of(ApplicationController).to receive(:current_player).and_return(@player_2)

#       visit waiting_room_path

#       expect(page).not_to have_button('Start Game')
#       expect(page).to have_content('elonsmusk')
#       expect(page).to have_content('taoistcowboy')
#       expect(page).to have_content('eros')
#     end
#     it 'See a registered player, and a guest player as the guest' do
#       allow_any_instance_of(ApplicationController).to receive(:current_player).and_return(@player_3)

#       visit waiting_room_path

#       expect(page).not_to have_button('Start Game')
#       expect(page).to have_content('elonsmusk')
#       expect(page).to have_content('taoistcowboy')
#       expect(page).to have_content('eros')
#     end
#   end
# end
