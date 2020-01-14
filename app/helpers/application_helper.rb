module ApplicationHelper
    def user_avatar(user, size=30)
        if user.avatar.attached?
            user.avatar.variant(resize: "#{size}x#{size}!")
        else
            gravatar_image_url(user.email, size: size, :alt => 'profile_pic', :gravatar => {:default => :identicon})
        end
    end
    def video_thumbnail(video)
        if video.thumbnail.attached?
            video.thumbnail.variant(resize: "200x100!")
        end
    end
end

