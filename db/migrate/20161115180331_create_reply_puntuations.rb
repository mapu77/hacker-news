class CreateReplyPuntuations < ActiveRecord::Migration[5.0]
  def change
    create_table :reply_puntuations do |t|
      t.references :reply, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
