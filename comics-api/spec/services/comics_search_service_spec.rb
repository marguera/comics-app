require 'rails_helper'

RSpec.describe "ComicsSearchService" do

  describe "find comics" do

    let(:rest_client) { spy }

    let(:api) {
      ComicsApiWrapper.new(
        public_key: "123",
        private_key: "456",
        timestamp: 1,
      )
    }

    let(:likes) { 
      (1..10).map { |i| Like.new( comic_id: i, count: 1 ) }
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
      allow(ComicsApiWrapper).to receive(:new).and_return(api)
      allow(api).to receive(:find).and_return(api_response)
      allow(Like).to receive(:from_comics_ids).and_return(likes)
    end

    it "returns comics" do
      service = ComicsSearchService.new
      expect(service.find).to be_a(Array)

      comic = service.find[0]
      expect(comic).to respond_to(:id)
      expect(comic).to respond_to(:title)
      expect(comic).to respond_to(:thumbnail)
      expect(comic).to respond_to(:likes)
      expect(comic.likes).to eq(1)
    end
  end
end
