class User < ApplicationRecord
  acts_as_commontator
  acts_as_voter
  acts_as_follower
  acts_as_followable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :videos, dependent: :destroy
end
