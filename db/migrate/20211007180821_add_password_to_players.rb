class AddPasswordToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :password, :string
  end
end
