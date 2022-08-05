class ComicsSearchService
  
  def initialize(marvel_api: MarvelApiAdapter.new)
    @marvel_api = marvel_api
  end

  def search_comics(options={})
    comics = Rails.cache.fetch("comics_api:find", expires_in: 24.hours) do
      get_comics(options)
    end
    parse_comics(comics)
  end
  
  private

    def get_comics(options)
      @marvel_api.find_comics(options)
    end

    def parse_comics(comics_json)
      result = JSON.parse(comics_json).deep_symbolize_keys
      result[:data][:results].map{ |json| Comic.from_json({ 
        id:        json[:id],
        title:     json[:title],
        thumbnail: json[:thumbnail][:path] + '.' + json[:thumbnail][:extension]
      }) }
    end
end