class ComicsSearchService
  
  RPP = 20

  def initialize(marvel_api: MarvelApiAdapter.new)
    @marvel_api = marvel_api
  end

  def search_comics(options={})
    if options[:character].present?
      ids = parse_characters_ids(character_query(options))
      return parse_results(comics_query(options).merge({ characters: ids.join(",") })) if ids.present?
      return { results: [] }
    end
    parse_results(comics_query(options))
  end
  
  private

    def get_comics(options={})
      cache_key = "comics_api:search_comics?#{options.to_query}"
      Rails.cache.fetch(cache_key, expires_in: 24.hours) do
        @marvel_api.find_comics(options)
      end
    end

    def parse_results(options={})
      json = JSON.parse(get_comics(options)).deep_symbolize_keys
      Hash.new.tap do |result|
        result[:_links] = build_links(json)
        result[:results] = build_comics_collection(json)
      end
    end

    def build_links(response)
      page = (response[:data][:offset] / 20) + 1
      is_first_page = page <= 1
      is_last_page = page >= response[:data][:total] / 20
      Hash.new.tap do |result|
        result[:prev] = page - 1 unless is_first_page
        result[:next] = page + 1 unless is_last_page
      end
    end

    def build_comics_collection(response)
      response[:data][:results].map{ |json| { 
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
      { orderBy: '-focDate', 
        limit:   RPP, 
        offset:  ([options[:page].to_i, 1].max - 1) * RPP }
    end
end