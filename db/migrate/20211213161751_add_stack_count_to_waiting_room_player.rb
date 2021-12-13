class AddStackCountToWaitingRoomPlayer < ActiveRecord::Migration[6.1]
  def change
    add_column :waiting_room_players, :stack_count, :integer
  end
end
