class ComicsSearchService
  
  def initialize(marvel_api: MarvelApiAdapter.new)
    @marvel_api = marvel_api
  end

  def search_comics(options={})
    if options[:character].present?
      ids = parse_characters_ids(character_query(options))
      return parse_comics(comics_query(options).merge({ characters: ids.join(",") })) if ids.present?
      return []
    end
    parse_comics
  end
  
  private

    def get_comics(options={})
      cache_key = "comics_api:search_comics?#{options.to_query}"
      Rails.cache.fetch(cache_key, expires_in: 24.hours) do
        @marvel_api.find_comics(options)
      end
    end

    def parse_comics(options={})
      result = JSON.parse(get_comics(options)).deep_symbolize_keys
      result[:data][:results].map{ |json| { 
        id:        json[:id],
        title:     json[:title],
        thumbnail: json[:thumbnail][:path] + '.' + json[:thumbnail][:extension]
      } }
    end

    def get_characters(options={})
      cache_key = "comics_api:search_characters?#{options.to_query}"
      Rails.cache.fetch(cache_key, expires_in: 24.hours ) do
        @marvel_api.find_characters(options)
      end
    end

    def parse_characters_ids(options={})
      result = JSON.parse(get_characters(options)).deep_symbolize_keys
      result[:data][:results].map{ |character| character[:id] }
    end

    def character_query(options={})
      { nameStartsWith: "#{options[:character]}", limit: 10 }
    end

    def comics_query(options={})
      { orderBy: '-focDate'  }
    end
end