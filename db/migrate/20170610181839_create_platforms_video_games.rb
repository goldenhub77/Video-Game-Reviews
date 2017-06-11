class CreatePlatformsVideoGames < ActiveRecord::Migration[5.1]
  def change
    create_join_table :platforms, :video_games do |t|
      t.index :video_game_id
      t.index :platform_id
    end
  end
end
