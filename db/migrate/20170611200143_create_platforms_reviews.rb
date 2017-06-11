class CreatePlatformsReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :platforms_reviews do |t|
      t.references :platform, null: false
      t.references :review, null: false
    end
  end
end
