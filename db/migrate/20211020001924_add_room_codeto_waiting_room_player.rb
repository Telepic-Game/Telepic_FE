class AddRoomCodetoWaitingRoomPlayer < ActiveRecord::Migration[6.1]
  def change
    add_column :waiting_room_players, :room_code, :string
  end
end
