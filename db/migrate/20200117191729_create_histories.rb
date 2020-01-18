class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.integer :count
      t.timestamps
    end
    add_reference :histories, :user, foreign_key: true
    add_reference :histories, :video, foreign_key: true
  end
end
