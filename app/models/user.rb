class User < ApplicationRecord
  acts_as_voter
  acts_as_follower
  acts_as_followable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: {maximum: 30}
  validates :avatar, blob: { content_type: :image }
  validates :banner, blob: { content_type: :image }
  
  has_many :videos, dependent: :destroy
  has_many :histories, dependent: :destroy

  has_one_attached :avatar
  has_one_attached :banner
end
