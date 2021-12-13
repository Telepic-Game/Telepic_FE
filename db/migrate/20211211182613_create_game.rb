class CreateGame < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.boolean :game_active, default: false
      t.boolean :all_players_ready, default: false
      t.references :waiting_room, null: false, foreign_key: true
      t.jsonb :game_players

      t.timestamps
    end
  end
end
