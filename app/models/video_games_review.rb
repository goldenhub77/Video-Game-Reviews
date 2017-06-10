class VideoGamesReview < ApplicationRecord
  belongs_to :video_game
  belongs_to :review
  
  validates :video_game_id, presence: true, numericality: true
  validates :review_id, presence: true, numericality: true
end
