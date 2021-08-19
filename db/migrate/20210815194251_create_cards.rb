class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :stack, foreign_key: true
      t.string :name
      t.json :image

      t.timestamps
    end
  end
end
