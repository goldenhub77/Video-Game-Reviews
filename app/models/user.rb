class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :video_games
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: ['member', 'admin'] }

  def admin?
    self.role == 'admin'
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.search(search)
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

end
