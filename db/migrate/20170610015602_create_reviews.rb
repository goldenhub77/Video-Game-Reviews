class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false
      t.string :title, null: false, limit: 30
      t.text :review, null: false
      t.string :platform_ids, null: false, array: true, default: []
      t.integer :rating, null: false, default: 3

      t.timestamps
    end
    change_column_default :video_games, :rating, from: 0, to: 3
  end
end
