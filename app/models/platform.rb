class Platform < ApplicationRecord

  validates :name, presence: true

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
