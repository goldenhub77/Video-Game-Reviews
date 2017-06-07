class CreateVideoGames < ActiveRecord::Migration[5.1]
  def change
    create_table :video_games do |t|
      t.string :title, null: false
      t.string :developer, null: false
      t.text :description, null: false
      t.string :platform_ids, null: false, array: true, default: []
      t.string :genre_id, null: false
      t.date :release_date, null: false
      t.integer :rating, null: false, default: 0
      t.decimal :price, null: false, precision: 8, scale: 2

      t.timestamps
    end
    add_index :video_games, :title, unique: true
  end
end
