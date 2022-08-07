class ComicsLikesService
  
  def enhance_comics_with_likes(comics, likes)
    comics.map do |comic| 
      comic.clone.tap do |h|
        h[:liked] = likes.dig(h[:id], :liked) || false
        h[:likes] = likes.dig(h[:id], :likes) || 0
      end
    end
  end

  def get_likes_from_comics(user_id, comics)
    comics_ids = comics.map{ |comic| comic[:id] }
    count = Like.from_comics_ids(comics_ids)
    liked = Like.user_liked_comics(user_id, comics_ids)
    map_likes(comics_ids, count, liked)
  end 

  def increment_likes_count(user_id, comic_id)
    Like.create(user_id: user_id, comic_id: comic_id)
  end

  private

    def map_likes(comics_ids, count, likes)
      comics_ids.map do |comic_id| 
        [ comic_id, { 
          liked: likes.include?(comic_id), 
          likes: count[comic_id] }]
      end.to_h
    end
end