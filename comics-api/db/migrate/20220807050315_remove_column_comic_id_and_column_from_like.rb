class RemoveColumnComicIdAndColumnFromLike < ActiveRecord::Migration[6.0]
  def change
    remove_column :likes, :comic_id, :string, index:true, unique: true
    remove_column :likes, :count, :integer
  end
end
