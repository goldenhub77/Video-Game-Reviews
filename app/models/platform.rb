class Platform < ApplicationRecord
  has_and_belongs_to_many :video_games
  has_and_belongs_to_many :reviews

  validates :name, presence: true

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
