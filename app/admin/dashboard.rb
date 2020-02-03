ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Videos" do
          ul do
            Video.all.order(created_at: :desc).limit(5).map do |video|
              li link_to(video.title, admin_video_path(video))
            end
          end
        end
      end

      columns do
        column do
          panel "Recent Comments" do
            ul do
              Comment.all.order(created_at: :desc).limit(5).map do |comment|
                li link_to(comment.body, admin_comment_path(comment))
              end
            end
          end
        end
      end

      columns do
        column do
          panel "Recent Users" do
            ul do
              User.all.order(created_at: :desc).limit(5).map do |user|
                li link_to(user.username, admin_user_path(user))
              end
            end
          end
        end
      end
    end
  end # content
end
