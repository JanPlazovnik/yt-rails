class RemoveComments < ActiveRecord::Migration[6.0]
  def change
    drop_table :comments
  end
end
