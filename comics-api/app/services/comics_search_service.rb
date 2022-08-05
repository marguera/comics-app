class ComicsSearchService

  def find
    comics = get_comics
    comics = enhance_comics_with_likes(comics)
    comics.map { |comic| Comic.from_json(comic) }
  end

  private
    
    def get_comics
      results = JSON.parse(comics_api.find()).deep_symbolize_keys
      results[:data][:results]
    end

    def comics_api
      @comics_api ||= ComicsApiWrapper.new(
        public_key: ENV['MARVEL_PUBLIC_KEY'],
        private_key: ENV['MARVEL_PRIVATE_KEY'],
        timestamp: Time.zone.now.to_i
      )
    end

    def enhance_comics_with_likes(comics)
      likes = Like.from_comics_ids(
        comics_ids: comics.map { |comic| comic[:id] } 
      )
      comics.map do |comic| 
        like = likes.find { |like| like.comic_id.to_s === comic[:id].to_s }
        comic.merge({ likes: like&.count || 0 })
      end
    end
end