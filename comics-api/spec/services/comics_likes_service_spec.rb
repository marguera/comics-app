require 'rails_helper'

RSpec.describe "ComicsLikesService" do
  let(:service) { ComicsLikesService.new }
  
  describe "#enhance_comics_with_likes" do

    it "returns an array of comics with likes" do
      comics = [
        Comic.from_json({ id: 1, title: "Comic 1", thumbnail: "http://comic1.com" }),
        Comic.from_json({ id: 2, title: "Comic 2", thumbnail: "http://comic2.com" }),
        Comic.from_json({ id: 3, title: "Comic 3", thumbnail: "http://comic3.com" })
      ]
      likes = [
        Like.new(comic_id: 3, count: 1),
        Like.new(comic_id: 2, count: 2),
        Like.new(comic_id: 1, count: 3)
      ]

      comics = service.enhance_comics_with_likes(comics, likes)
      expect(comics[0].likes).to eq(3)
      expect(comics[1].likes).to eq(2)
      expect(comics[2].likes).to eq(1)
    end
  end 
end
