class Like < ApplicationRecord
  validates :comic_id, uniqueness: { scope: :user_id }

  # count likes + liked
  def self.from_comics_ids(comics_ids)
    self.group(:user_id).where(comic_id: comics_ids).count
  end
end
