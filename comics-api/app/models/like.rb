class Like < ApplicationRecord
  validates :comic_id, uniqueness: { scope: :user_id }

  # count likes + liked
  def self.from_comics_ids(comics_ids)
    self.group(:user_id).where(comic_id: comics_ids).count
  end

  def self.user_liked_comics(user_id, comics_ids)
    self.where(user_id: user_id, comic_id: comics_ids).pluck(:comic_id)
  end
end
