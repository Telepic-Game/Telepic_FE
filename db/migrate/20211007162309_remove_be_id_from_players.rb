class RemoveBeIdFromPlayers < ActiveRecord::Migration[6.1]
  def change
    remove_column :players, :be_id, :string
  end
end
