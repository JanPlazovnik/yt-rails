class User < ApplicationRecord
  acts_as_voter
  acts_as_follower
  acts_as_followable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :avatar, blob: { content_type: :image }
  
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
end
