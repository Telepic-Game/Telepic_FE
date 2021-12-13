class AddCardCountToWaitingRoomPlayer < ActiveRecord::Migration[6.1]
  def change
    add_column :waiting_room_players, :card_count, :integer
  end
end
