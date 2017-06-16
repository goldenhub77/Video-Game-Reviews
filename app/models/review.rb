class Review < ApplicationRecord
  belongs_to :user
  belongs_to :video_game
  has_and_belongs_to_many :platforms

  validates :user_id, presence: true, numericality: true
  validates :title, presence: true, length: { minumum: 10, maximum: 30 }
  validates :review, presence: true, length: { minimum: 50, maximum: 300 }
  validates :rating, presence: true, numericality: true
  validates_presence_of :platforms
  validates_presence_of :video_game

  def self.search(search)
    where("title ILIKE ? OR review ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def self.status
    if Review.all.empty?
      "There are currently no reviews available, but you can add one."
    end
  end
end
