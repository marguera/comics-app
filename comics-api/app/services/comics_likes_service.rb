class ComicsLikesService
  
  def enhance_comics_with_likes(comics, likes)
    likes = map_likes(likes)
    comics.map do |comic| 
      Comic.from_json({ 
        id: comic.id,
        title: comic.title,
        thumbnail: comic.thumbnail,
        likes: likes[comic.id.to_s] || 0
      })
    end
  end

  def get_likes_from_comics(comics)
    Like.from_comics_ids(comics.map(&:id))
  end 

  def increment_likes_count(comic_id:)
    like = Like.find_or_initialize_by(:comic_id => comic_id)
    like.increment!(:count) if like.persisted?
    like.save if like.new_record?
  end

  private

    def map_likes(likes)
      likes.map{ |like| [like.comic_id, like.count] }.to_h
    end
end