class VideoGame < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :developer, presence: true
  validates :description, presence: true, length: { minimum: 15 }
  validates :platforms, presence: true
  validates :genre, presence: true
  validates :release_date, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, great_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
