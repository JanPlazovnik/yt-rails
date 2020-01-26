class User < ApplicationRecord
  acts_as_voter
  acts_as_follower
  acts_as_followable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true, length: {maximum: 30}
  validates :avatar, blob: { content_type: :image }
  validates :banner, blob: { content_type: :image }
  
  has_many :videos, dependent: :destroy
  has_many :histories, dependent: :destroy

  has_one_attached :avatar
  has_one_attached :banner

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
    end
  end
end
