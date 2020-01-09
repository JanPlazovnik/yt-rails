class AddUserRefToVideos < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :user, foreign_key: true
  end
end
