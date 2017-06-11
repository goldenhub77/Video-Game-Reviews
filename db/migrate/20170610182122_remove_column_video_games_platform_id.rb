class RemoveColumnVideoGamesPlatformId < ActiveRecord::Migration[5.1]
  def change
    remove_column :video_games, :platform_ids, :string, default: [], array: true
  end
end
