class ReviewVote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :vote, presence: true, inclusion: { in: -1..1}
  validates :user_id, presence: true, numericality: true
  validates :review_id, presence: true, numericality: true
  validates_uniqueness_of :user_id, :scope => :review_id
end
