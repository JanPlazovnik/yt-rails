class Video < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
end
