require 'rails_helper'

RSpec.describe "ComicsLikesService" do

  let(:service) { ComicsLikesService.new }
  
  describe "#enhance_comics_with_likes" do

    let(:comics) { 
      [ Comic.from_json({ id: 1, title: "Comic 1", thumbnail: "http://comic1.com" }),
        Comic.from_json({ id: 2, title: "Comic 2", thumbnail: "http://comic2.com" }),
        Comic.from_json({ id: 3, title: "Comic 3", thumbnail: "http://comic3.com" }) ] 
    }

    let(:likes) { 
      [ Like.new(comic_id: 3, count: 1),
        Like.new(comic_id: 2, count: 2),
        Like.new(comic_id: 1, count: 3) ]
    }

    context "with matching comics and likes" do

      it "returns an array of comics with likes" do
        result = service.enhance_comics_with_likes(comics, likes)
        expect(result[0].likes).to eq(3)
        expect(result[1].likes).to eq(2)
        expect(result[2].likes).to eq(1)
      end
    end

    context "without likes" do
      it "returns an array of comics with likes" do
        result = service.enhance_comics_with_likes(comics, [])
        expect(result[0].likes).to eq(0)
        expect(result[1].likes).to eq(0)
        expect(result[2].likes).to eq(0)
      end
    end

    context "without comics" do
      it "returns an empty array" do
        result = service.enhance_comics_with_likes([], likes)
        expect(result).to be_a(Array)
        expect(result).to be_empty

        result = service.enhance_comics_with_likes([], [])
        expect(result).to be_a(Array)
        expect(result).to be_empty
      end
    end
  end 
end
