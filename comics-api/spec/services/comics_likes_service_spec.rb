require 'rails_helper'

RSpec.describe "ComicsLikesService" do

  let(:service) { ComicsLikesService.new }
  
  describe "#enhance_comics_with_likes" do

    let(:comics) { 
      { 
        _links: { next: 3, prev: 2, },
        results: [
          { id: 1, title: "title 1", thumbnail: "e1", likes: 2, liked: false },
          { id: 2, title: "title 2", thumbnail: "e1", likes: 2, liked: false },
          { id: 3, title: "title 3", thumbnail: "e1", likes: 2, liked: false },
          { id: 4, title: "title 4", thumbnail: "e1", likes: 2, liked: false },
          { id: 5, title: "title 5", thumbnail: "e1", likes: 2, liked: false }
        ]
      }
    }

    let(:likes) { 
      { 
        3 => { likes: 1 }, 
        2 => { likes: 2 }, 
        1 => { likes: 3 }
      } 
    }

    context "with matching comics and likes" do
      it "returns an array of comics with likes" do
        result = service.enhance_comics_with_likes(comics, likes)
        expect(result[:results][0][:likes]).to eq(3)
        expect(result[:results][1][:likes]).to eq(2)
        expect(result[:results][2][:likes]).to eq(1)
      end
    end

    context "without likes" do
      it "returns an array of comics with likes" do
        result = service.enhance_comics_with_likes(comics, {})
        expect(result[:results][0][:likes]).to eq(0)
        expect(result[:results][1][:likes]).to eq(0)
        expect(result[:results][2][:likes]).to eq(0)
      end
    end

    context "without comics" do

      let(:comics) { 
        {
          _links: {},
          results: []
        }
      }
      it "returns an empty array" do
        result = service.enhance_comics_with_likes(comics, likes)
        expect(result[:results]).to be_a(Array)
        expect(result[:results]).to be_empty

        result = service.enhance_comics_with_likes(comics, {})
        expect(result[:results]).to be_a(Array)
        expect(result[:results]).to be_empty
      end
    end
  end 
end
