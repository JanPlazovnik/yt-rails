class AddLengthToVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :video_length, :integer, :default => 0
  end
end
