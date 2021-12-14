class AddReadyUpCounterToWaitingRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :waiting_rooms, :ready_up_counter, :integer
  end
end
