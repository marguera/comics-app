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
    res = request('/comics', options).body
  end

  def find_characters(options={})
    res = request('/characters', options).body
  end

  private

  def compact_blank(options)
    options.clone.delete_if { |_,v| v.blank? }
  end

  def request(path, options={})
    RestClient.get("#{ENDPOINT}#{path}", { 
      params: auth.merge(compact_blank(options)) })
  end

  def auth
    { ts: @timestamp, apikey: @public_key, hash: md5_hash }
  end

  def md5_hash
    Digest::MD5.hexdigest("#{@timestamp}#{@private_key}#{@public_key}")
  end
end
