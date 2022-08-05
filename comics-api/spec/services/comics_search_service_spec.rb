require 'rails_helper'

RSpec.describe "ComicsSearchService" do
  describe "#search_comics" do
    let(:service) { ComicsSearchService.new }
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
      Rails.cache.clear
    end

    it "should cache the comic's api request" do
      allow(service).to receive(:get_comics).and_return(api_response)
      expect(service).to receive(:get_comics).once
      service.search_comics
      service.search_comics
    end
  end
end