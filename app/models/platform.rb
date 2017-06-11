class Platform < ApplicationRecord
  has_and_belongs_to_many :video_games

  validates :name, presence: true

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
