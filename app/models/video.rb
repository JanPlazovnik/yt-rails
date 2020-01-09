class Video < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
    
    validates :clip, presence: true, blob: { content_type: :video }
    validates :thumbnail, blob: { content_type: :image }

    belongs_to :user
end
