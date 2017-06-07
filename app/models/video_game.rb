class VideoGame < ApplicationRecord
  belongs_to :user
  
#you must restart server after updating platforms and genres for changes to take effect
  PLATFORMS =
  [
    { name: 'Windows' },
    { name: 'Mac' },
    { name: 'Linux' },
    { name: 'Xbox' },
    { name: 'Xbox 360' },
    { name: 'Xbox One' },
    { name: 'Playstation' },
    { name: 'Playstation 2' },
    { name: 'Playstation 3' },
    { name: 'Playstation 4' },
    { name: 'Android' },
    { name: 'IOS' }
  ]

  GENRES =
  [
    { name: 'First Person Shooter', abbr: 'FPS' },
    { name: 'Adventure', abbr: 'ADV' },
    { name: 'Role Playing Game', abbr: 'RPG' },
    { name: 'Puzzle'},
    { name: 'Simulation', abbr: 'SIM' },
    { name: 'Strategy' },
    { name: 'Sports' },
    { name: 'Fighting' },
    { name: 'Survival' }
  ]

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :developer, presence: true
  validates :description, presence: true, length: { minimum: 15 }
  validates :platform_ids, presence: true
  validates :genre_id, presence: true
  validates :release_date, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, great_than_or_equal_to: 0, less_than_or_equal_to: 100 }


  def platforms
    self.platform_ids.map { |platform| Platform.where('id = ?', platform).first}
  end

  def genre
    Genre.where('id = ?', self.genre_id).first
  end

  def self.search(search)
    where("title ILIKE ? OR description ILIKE ? OR developer ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
