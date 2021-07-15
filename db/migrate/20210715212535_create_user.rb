class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: true
      t.string :be_id, null: true

      t.timestamps
    end
  end
end
