require 'rails_helper'

RSpec.describe "ComicsSearchService" do

  describe "find comics" do

    let(:service) { ComicsSearchService.new }
    
    let(:api) { comics_api_wrapper }

    let(:api_response) { comics_api_response_json }

    let(:likes) { 
      (1..10).map { |i| Like.create( comic_id: i, count: 1 ) }
    }

    before do 
      allow(service).to receive(:comics_api).and_return(api)
      allow(service).to receive(:get_likes).with(anything).and_return(likes)
    end

    context "skip caching" do
      before do 
        allow(service).to receive(:get_comics).and_return(api_response)
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

    context "with caching" do

      before do 
        Rails.cache.clear
        allow(api).to receive(:find).and_return(api_response)
      end

      it "should cache the comic's api request" do
        expect(api).to receive(:find).once
        service.find
        service.find
      end
    end
  end
end
