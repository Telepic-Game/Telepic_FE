require 'rails_helper'

RSpec.describe "Waiting Room - Hotwire Tests", type: :feature do
  after :all do
    WaitingRoomPlayer.destroy_all
    WaitingRoom.destroy_all
    WaitingRoomPlayer.destroy_all
    Player.destroy_all
  end
  describe "Hotwire works as expected" do
    it "Guest can open waiting room" do
      visit root_path
      click_button "Start Waiting Room as a Guest"
      fill_in :username, with: "Jordan Beck"
      fill_in :player_count, with: 3
      click_button "Open Waiting Room"

      expect(page.first('div#waiting_room_player').text).to eq('Jordan Beck')

      within 'div#player_count' do
        expect(page).to have_content("3 Player Game")
      end

      expect(current_path).to eq(waiting_room_path)

      room_code = WaitingRoom.first.room_code

      visit root_path
      click_button "Join Game"
      fill_in :username, with: "Kris Litman"
      fill_in :room_code, with: room_code
      click_button "Join Waiting Room"

      expect(current_path).to eq(waiting_room_path)

      visit root_path
      click_button "Join Game"
      fill_in :username, with: "Kyle Schulz"
      fill_in :room_code, with: room_code
      click_button "Join Waiting Room"
save_and_open_page
      expect(current_path).to eq(waiting_room_path)

      group = find_all('div#waiting_room_player').to_a
# require "pry"; binding.pry # Needs timer here, to move from waiting room, to round 1? Maybe a ready up? Get rid of flash message,
      expect(group.last.text).to eq('Kyle Schulz')
      expect(group.second.text).to eq('Kris Litman')
      expect(group.first.text).to eq('Jordan Beck')
      expect(current_path).to eq(waiting_room_path)

      click_on("Start Game")


# We will not be able to have a player ready up in waiting room, unless we have a hard counter for a pre determined amount of players, which could make some of the other code easier, not having to be dynamic.

#next step is to use hotwire, to direct al players to the portion of the view which is for gameplay, aka round one. I wonder if wrapping the entire index.html.erb in the waiting room views, as a conditional based on the status of game_active?

# visit waiting_room_path for host "Jordan", and click on "Start Game"

#expect current_path to eq(game_path#show(current_user.card_1))

#game_path - "This might be a game index that will hold all of the data, for all the stacks in a current game, stacks being determined by players in game when started. Then, the game_show page, would hold an individual players stack, with an amount of cards in it determined by the amount of players, when the game is started. The cards in a players stack will be updated automatically as the timer moves forward, likewise - the view will change to display the next card in a next/previous players stack upon the timer reaching its mark.
    end
  end
end
