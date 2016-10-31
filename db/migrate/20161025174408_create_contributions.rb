class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.text :title
      t.text :content
      t.references :user, foreign_key: true
      t.datetime :created_at

      t.timestamps
    end
  end
end
