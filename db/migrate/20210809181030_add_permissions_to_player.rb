class AddPermissionsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :permissions, :string
  end
end
