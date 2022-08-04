require 'rails_helper'

RSpec.describe "ComicsApiWrapper", :vcr do
  describe "GET /comics" do
    let (:comics_response) { ComicsApiWrapper.get_comics() }
    it "returns correct data" do
      expect(comics_response[:code]).to eq(200)
      expect(comics_response).to have_key(:data)
      expect(comics_response[:data]).to have_key(:results)
      expect(comics_response[:data]).to have_key(:results)
      expect(comics_response[:data][:results]).to be_an(Array)
      expect(comics_response[:data][:results][0]).to have_key(:id)
      expect(comics_response[:data][:results][0]).to have_key(:title)
      expect(comics_response[:data][:results][0]).to have_key(:thumbnail)
    end
  end
end
