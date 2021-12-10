class AddPermissionsToWaitingRoomPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :waiting_room_players, :permissions, :string
  end
end
