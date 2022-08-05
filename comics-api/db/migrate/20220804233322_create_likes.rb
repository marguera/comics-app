class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.string :comic_id, :index => true, :unique => true
      t.integer :count, default: 1
      t.timestamps
    end
  end
end
