class AddColumnUserIdToVideoGame < ActiveRecord::Migration[5.1]
  def change
    add_column :video_games, :user_id, :integer, null: false
  end
end
