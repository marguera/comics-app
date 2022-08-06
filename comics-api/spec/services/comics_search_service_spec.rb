require 'rails_helper'

RSpec.describe "ComicsSearchService" do
  describe "#search_comics" do
    let(:api) { MarvelApiAdapter.new }
    let(:service) { ComicsSearchService.new(marvel_api: api) }
    let(:comics_response) { 
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
    let(:characters_response) { 
      { 
        data: {
          results: [
            { id: 1, name: "name 1" },
            { id: 2, name: "name 2" }
           ]
        }
      }.to_json 
    }

    before do 
      Rails.cache.clear
      allow(api).to receive(:find_comics).and_return(comics_response)
      allow(api).to receive(:find_characters).and_return(characters_response)
    end

    context "with params[:character]" do

      it "should call character search with limit of 10 results" do
        expect(api).to receive(:find_characters).with(hash_including({ limit: 10 }))
        service.search_comics({ character: "123" })
      end

      it "should call comics search with a list of characters" do
        expect(api).to receive(:find_comics).with(hash_including({ characters: "1,2" }))
        service.search_comics({ character: "123" })
      end

      it "should call the api if character was found" do
        expect(api).to receive(:find_characters)
        expect(api).to receive(:find_comics)
        service.search_comics({ character: "123" })
      end

      it "should cache the comics search request" do
        expect(api).to receive(:find_characters).once
        expect(api).to receive(:find_comics).once
        service.search_comics({ character: "123" })
        service.search_comics({ character: "123" })
      end

      it "should cache the characters search request" do
        expect(api).to receive(:find_comics).once
        expect(api).to receive(:find_characters).once
        service.search_comics({ character: "123" })
        service.search_comics({ character: "123" })
      end
      
      it "should not call the api if character is empty" do
        expect(api).to_not receive(:find_characters)
        expect(api).to receive(:find_comics)
        service.search_comics({ character: [] })
      end
    end

    context "without params" do

      it "should not call the api if character is not provided" do
        expect(api).to_not receive(:find_characters)
        expect(api).to receive(:find_comics)
        service.search_comics({})
      end

      it "should cache the comics search request" do
        expect(api).to_not receive(:find_characters)
        expect(api).to receive(:find_comics).once
        service.search_comics
        service.search_comics
      end
    end

  end
end