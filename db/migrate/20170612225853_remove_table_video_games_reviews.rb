class RemoveTableVideoGamesReviews < ActiveRecord::Migration[5.1]
  def change
    drop_table :video_games_reviews
  end
end
