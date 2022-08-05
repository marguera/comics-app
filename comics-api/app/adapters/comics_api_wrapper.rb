class ComicsApiWrapper

  def initialize rest_client, url:, public_key:, private_key:, timestamp:
    @rest_client = rest_client
    @url         = url
    @public_key  = public_key
    @private_key = private_key
    @timestamp   = timestamp
  end

  def find
    puts authenticated_endpoint_for(path: "comics")
    url = authenticated_endpoint_for(path: "comics")
    response = @rest_client.get(url)
    response.body
  end

  private

  def authenticated_endpoint_for(path:)
    "#{@url}/#{path}?ts=#{@timestamp}&apikey=#{@public_key}&hash=#{md5_hash}"
  end

  def md5_hash
    Digest::MD5.hexdigest("#{@timestamp}#{@private_key}#{@public_key}")
  end
end
