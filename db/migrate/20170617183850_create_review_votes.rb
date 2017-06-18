class CreateReviewVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :review_votes do |t|
      t.integer :vote, null: false
      t.references :user, null: false
      t.references :review, null: false

      t.timestamps
    end
  end
end
