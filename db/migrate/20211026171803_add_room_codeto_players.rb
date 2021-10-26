class AddRoomCodetoPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :room_code, :string
  end
end
