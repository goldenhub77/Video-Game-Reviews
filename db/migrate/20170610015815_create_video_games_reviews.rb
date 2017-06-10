class CreateVideoGamesReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :video_games_reviews do |t|
      t.references :video_game, null: false
      t.references :review, null: false

      t.timestamps
    end
  end
end
