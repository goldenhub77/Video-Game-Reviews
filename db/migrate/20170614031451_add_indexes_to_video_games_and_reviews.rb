class AddIndexesToVideoGamesAndReviews < ActiveRecord::Migration[5.1]
  def change
    add_index(:video_games, :user_id)
    add_index(:reviews, :video_game_id)
  end
end
