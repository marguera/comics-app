require 'rails_helper'

RSpec.describe "ComicsSearchService" do

  describe "find comics" do

    let(:service) { ComicsSearchService.new }

    let(:api) {
      ComicsApiWrapper.new(
        public_key: "123",
        private_key: "456",
        timestamp: 1,
      )
    }

    let(:likes) { 
      (1..10).map { |i| Like.create( comic_id: i, count: 1 ) }
    }

    let(:api_response) { 
      { 
        data: {
          results: [
            { id: 1, title: "title 1", thumbnail: { path: "p1", extension: "e1" } },
            { id: 2, title: "title 2", thumbnail: { path: "p1", extension: "e1" } },
            { id: 3, title: "title 3", thumbnail: { path: "p1", extension: "e1" } },
            { id: 4, title: "title 4", thumbnail: { path: "p1", extension: "e1" } },
            { id: 5, title: "title 5", thumbnail: { path: "p1", extension: "e1" } }
          ]
        }
      }.to_json
    }

    before do 
      allow(service).to receive(:comics_api).and_return(api)
      allow(api).to receive(:find).and_return(api_response)
      allow(service).to receive(:get_likes).with(anything).and_return(likes)
    end

    it "returns comics" do
      comics = service.find
      expect(comics).to be_a(Array)
      expect(comics.first).to respond_to(:id)
      expect(comics.first).to respond_to(:title)
      expect(comics.first).to respond_to(:thumbnail)
      expect(comics.first).to respond_to(:likes)
      expect(comics.first.likes).to eq(1)
    end
  end
end
