class AddColumnVideoGameIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :video_game_id, :integer, null: false
  end
end
