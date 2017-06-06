class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :video_games, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: ['member', 'admin'] }

  def is_admin?
    self.role == 'admin'
  end
end
