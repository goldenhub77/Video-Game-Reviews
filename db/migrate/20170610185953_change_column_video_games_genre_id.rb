class ChangeColumnVideoGamesGenreId < ActiveRecord::Migration[5.1]
  def change
    change_column :video_games, :genre_id, 'integer USING genre_id::integer'
  end
end
