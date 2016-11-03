class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.text :title
      t.text :url
      t.text :text
      t.integer :puntuation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
