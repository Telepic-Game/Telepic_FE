class CreateStacks < ActiveRecord::Migration[5.2]
  def change
    create_table :stacks do |t|
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
