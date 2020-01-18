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
    def upload_thumbnail(video, x, y)
        if video.thumbnail.attached?
            video.thumbnail.variant(resize: "#{x}x#{y}!")
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
    def count_views(video)
        views = video.histories.count
        if views == 1
            views.to_s + " view"
        else
            views.to_s + " views"
        end
    end
    def convert_duration(video)
        duration = video.video_length
        if duration >= 3600
            Time.at(duration).utc.strftime("%H:%M:%S")
        else
            Time.at(duration).utc.strftime("%M:%S")
        end
    end
end
