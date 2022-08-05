class ComicsSearchService

  def find
    comics = get_comics
    comics = enhance_comics_with_likes(comics)
    comics.map { |comic| Comic.from_json(comic) }
  end

  private

    def comics_api
      @comics_api ||= ComicsApiWrapper.new(
        public_key: ENV['MARVEL_PUBLIC_KEY'],
        private_key: ENV['MARVEL_PRIVATE_KEY'],
        timestamp: Time.zone.now.to_i
      )
    end
    
    def get_comics
      results = JSON.parse(comics_api.find()).deep_symbolize_keys
      results[:data][:results]
    end

    def enhance_comics_with_likes(comics)
      likes = get_likes(comics.map{ |comic| comic[:id] })
      likes = map_likes(likes)
      comics.map do |comic| 
        comic.merge({ likes: likes[comic[:id].to_s] || 0 })
      end
    end

    def get_likes(comics_ids)
      Like.from_comics_ids(comics_ids: comics_ids)      
    end

    def map_likes(likes)
      likes.map{ |like| [like.comic_id, like.count] }.to_h
    end
end