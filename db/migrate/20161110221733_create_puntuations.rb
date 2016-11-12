class CreatePuntuations < ActiveRecord::Migration[5.0]
  def change
    create_table :puntuations do |t|
      t.integer :user_id
      t.integer :contribution_id

      t.timestamps
    end
    add_index :puntuations, :user_id
    add_index :puntuations, :contribution_id
  end
end
