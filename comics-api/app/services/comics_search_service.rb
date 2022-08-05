class ComicsSearchService

  def find
    comics = parse_comics(get_comics)
    comics = enhance_comics_with_likes(comics)
    comics.map { |comic| Comic.from_json(comic) }
  end

  private

    def comics_api
      @comics_api ||= MarvelApiAdapter.new(
        public_key: ENV['MARVEL_PUBLIC_KEY'],
        private_key: ENV['MARVEL_PRIVATE_KEY'],
        timestamp: Time.zone.now.to_i
      )
    end
    
    def get_comics
      Rails.cache.fetch("comics_api:find", expires_in: 24.hours) do
        comics_api.find()
      end
    end

    def parse_comics(json)
      result = JSON.parse(json).deep_symbolize_keys
      result[:data][:results]
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