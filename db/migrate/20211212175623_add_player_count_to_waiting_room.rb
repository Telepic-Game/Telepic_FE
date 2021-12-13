class AddPlayerCountToWaitingRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :waiting_rooms, :player_count, :integer
  end
end
