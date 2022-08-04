class MarvelComicsApiClient 
  BASE_ENDPOINT = "http://gateway.marvel.com/v1/public"

  class << self
    def get_comics
      url = self.authenticated_endpoint_for(path: "comics", timestamp: Time.now.to_i)
      response = RestClient.get(url)
      JSON.parse(response.body)
    end

    def authenticated_endpoint_for(path:, timestamp:)
      key  = ENV['MARVEL_PUBLIC_KEY']
      hash = Digest::MD5.hexdigest("#{timestamp}#{ENV['MARVEL_PRIVATE_KEY']}#{key}")
      "#{BASE_ENDPOINT}/#{path}?ts=#{timestamp}&apikey=#{key}&hash=#{hash}"
    end
  end
end
