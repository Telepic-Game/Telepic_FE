class ChangeUsersToPlayers < ActiveRecord::Migration[5.2]
  def change
    rename_table :users, :players
  end
end
