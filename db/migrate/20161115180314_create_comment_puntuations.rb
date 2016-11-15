class CreateCommentPuntuations < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_puntuations do |t|
      t.references :comment, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
