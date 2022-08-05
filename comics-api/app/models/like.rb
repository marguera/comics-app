class Like < ApplicationRecord
  validates :comic_id, uniqueness: { case_sensitive: false }

  def self.from_comics_ids(comics_ids:)
    self.where(comic_id: comics_ids).all
  end
end
