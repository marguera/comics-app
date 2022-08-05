class MarvelApiAdapter
  ENDPOINT = "http://gateway.marvel.com/v1/public"
  
  def initialize(public_key:, private_key:, timestamp:)
    @public_key  = public_key
    @private_key = private_key
    @timestamp   = timestamp
  end

  def find_comics
    request('/comics').body
  end
 
  private

  def request(path)
    RestClient.get("#{ENDPOINT}#{path}", { params: auth })
  end

  def auth
    { ts: @timestamp, apikey: @public_key, hash: md5_hash }
  end

  def md5_hash
    Digest::MD5.hexdigest("#{@timestamp}#{@private_key}#{@public_key}")
  end
end
