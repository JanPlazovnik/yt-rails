module ApplicationHelper
    def user_avatar(user, size=30)
        puts "YOOO GETTING YOUR AVATAR"
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
    def frontpage_thumbnail(video)
        if video.thumbnail.attached?
            video.thumbnail.variant(resize: "300x150!")
        end
    end
    def user_subscribers(user) 
        if user.followers_count == 1
            user.followers_count.to_s + " subscriber"
        else
            user.followers_count.to_s + " subscribers"
        end
    end
    def has_liked(user, video)
        classes = ["video-meta-item"]
        if (user.voted_as_when_voted_for video) && (current_user.voted_as_when_voted_for video) == true
            classes << "voted"
        end
        return classes
    end
    def has_disliked(user, video)
        classes = ["video-meta-item"]
        if (user.voted_as_when_voted_for video) == false
            classes << "voted"
        end
        return classes
    end
end
