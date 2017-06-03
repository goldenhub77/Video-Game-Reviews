class RemoveColumnPriceInVideoGame < ActiveRecord::Migration[5.1]
  def change
    remove_column :video_games, :price, :decimal
  end
end
