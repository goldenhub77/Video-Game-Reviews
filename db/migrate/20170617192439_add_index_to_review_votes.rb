class AddIndexToReviewVotes < ActiveRecord::Migration[5.1]
  def change
    add_index :review_votes, [:user_id, :review_id], unique: true
  end
end
