class MarvelApiAdapter
  ENDPOINT = "http://gateway.marvel.com/v1/public"
  
  def initialize
    @public_key  = ENV['MARVEL_PUBLIC_KEY']
    @private_key = ENV['MARVEL_PRIVATE_KEY']
    @timestamp   = Time.zone.now.to_i
  end

  def configure
    yield self
  end

  def find_comics(options={})
    request('/comics', options).body
  end

  private

  def request(path, options={})
    RestClient.get("#{ENDPOINT}#{path}", { params: auth.merge(options) })
  end

  def auth
    { ts: @timestamp, apikey: @public_key, hash: md5_hash }
  end

  def md5_hash
    Digest::MD5.hexdigest("#{@timestamp}#{@private_key}#{@public_key}")
  end
end
