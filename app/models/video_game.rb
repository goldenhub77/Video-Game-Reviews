class VideoGame < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :reviews
  has_and_belongs_to_many :platforms

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :developer, presence: true
  validates :description, presence: true, length: { minimum: 15 }
  validates :genre_id, presence: true
  validates :release_date, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates_presence_of :platforms

  def self.search(search)
    where("title ILIKE ? OR description ILIKE ? OR developer ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
