class Comic
  attr_reader :id, :title, :thumbnail, :likes
  
  def self.from_json(json)
    self.new(
      json[:id], 
      json[:title], 
      json[:thumbnail][:path] + '.' + json[:thumbnail][:extension], 
      json[:likes] )
  end

  private
  
  def initialize(id, title, thumbnail, likes)
    @id = id
    @title = title
    @thumbnail = thumbnail
    @likes = likes
  end
end