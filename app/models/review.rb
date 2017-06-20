class Review < ApplicationRecord
  belongs_to :user
  belongs_to :video_game
  has_and_belongs_to_many :platforms
  has_many :review_votes, dependent: :destroy

  validates :user_id, presence: true, numericality: true
  validates :title, presence: true, length: { minumum: 10, maximum: 30 }
  validates :review, presence: true, length: { minimum: 50, maximum: 300 }
  validates :rating, presence: true, numericality: true
  validates_presence_of :platforms
  validate :platform_check
  validates_presence_of :video_game

  def platform_check
    if platforms.present?
      (video_game.platforms.map { |game_platform| game_platform.name == platforms.first.name }).include?(true)
    end
  end

  def self.search(search)
    where("title ILIKE ? OR review ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def self.status
    if Review.all.empty?
      "There are currently no reviews available, but you can add one."
    end
  end

  def total_rating
    sum = review_votes.inject(0) { |sum, review| sum + review.vote }
    avg = (sum.to_f/review_votes.count*100).round(2)
    if avg < 0
      "0%"
    elsif avg.nan?
      "No ratings!"
    else
      "#{avg}%"
    end
  end

  def user_voted?(user)
    review_votes.where('user_id = ?', user.id).present?
  end

  def voted_thumbs_up?(user)
    if user_voted?(user)
      review_votes.where('user_id = ?', user.id).first.vote == 1
    end
  end

  def voted_thumbs_down?(user)
    if user_voted?(user)
      review_votes.where('user_id = ?', user.id).first.vote == -1
    end
  end
end
