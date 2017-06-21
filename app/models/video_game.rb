class VideoGame < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :platforms

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :developer, presence: true
  validates :description, presence: true, length: { minimum: 15 }
  validates :genre_id, presence: true
  validates :release_date, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates_presence_of :platforms

  def self.search(search)
    games = joins(:user).where("users.first_name ILIKE ? OR users.last_name ILIKE ? OR title ILIKE ? OR description ILIKE ? OR developer ILIKE ? OR user ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").order("created_at DESC")
  end

  def rating_avg
    total_ratings = reviews.count + 1
    summed_ratings = reviews.inject(0) { |sum, review| sum + review.rating } + rating
    avg = (summed_ratings.to_f/total_ratings).round(2)
    "#{avg} / 5.0"
  end
end
