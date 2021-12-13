class AddPlayerReadyToPlayer < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :player_ready, :boolean, default: false
    add_column :players, :game_id, :string, null: true
  end
end
