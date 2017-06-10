class Review < ApplicationRecord
  belongs_to :user
  has_many :video_games_reviews
  has_many :video_games, through: :video_games_reviews

  validates :user_id, presence: true, numericality: true
  validates :title, presence: true, length: { minumum: 10, maximum: 30 }
  validates :review, presence: true, length: { minimum: 50, maximum: 300 }
  validates :platform_ids, presence: true
  validates :rating, presence: true, numericality: true
end
