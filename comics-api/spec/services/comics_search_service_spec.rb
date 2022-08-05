require 'rails_helper'

RSpec.describe "ComicsSearchService" do

  describe "find comics" do

    let(:rest_client) { spy }

    let(:api) {
      ComicsApiWrapper.new(rest_client, 
        url: "u",
        public_key: "pu",
        private_key: "pr",
        timestamp: "t"
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
      expect(service.find[0]).to respond_to(:id)
      expect(service.find[0]).to respond_to(:title)
      expect(service.find[0]).to respond_to(:thumbnail)
      expect(service.find[0]).to respond_to(:likes)
    end

    # let(:comics) {
    #   [
    #     {
    #       id: 1,
    #       title: "Superman",
    #       thumbnail: { 
    #         path: "image_path",
    #         extension: "image_extension"
    #        }
    #     }
    #   ]
    # }
    # it "returns the list of comics" do
    #   service = ComicsSearchService.new(adapter)
    #   results = service.find
    #   comic = comics[0]
    #   expect(LikesRepository).to receive(:get_likes) { comics }
    #   expect(ComicsRepository).to receive(:get_comics) { comics }
    #   expect(adapter).to receive(:get_comics)
    #   expect(results).to be_a(Array)
    #   expect(results[0][:id]).to eq(comic[:id])
    #   expect(results[0][:title]).to eq(comic[:title])
    #   expect(results[0][:thumbnail]).to eq("#{comic[:thumbnail][:path]}.#{comic[:thumbnail][:extension]}")
    # end
  end
end
