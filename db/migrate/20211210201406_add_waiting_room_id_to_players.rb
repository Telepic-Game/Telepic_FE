class AddWaitingRoomIdToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :waiting_room_id, :bigint
  end
end
