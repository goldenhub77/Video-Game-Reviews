class RemoveColumnPlatformIdFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :platform_ids, :string, default: [], array: true
  end
end
