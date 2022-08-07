class AddColumnComicIdAndIndexToLike < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :comic_id, :integer
    add_index :likes, [:user_id, :comic_id], unique: true
  end
end
