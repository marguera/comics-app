require 'rails_helper'

RSpec.describe "ComicsApiWrapper" do
  describe "find comics" do
    let(:rest_client) { spy }
    let(:api) {
      ComicsApiWrapper.new(rest_client, 
        url: "1",
        public_key: "2",
        private_key: "3",
        timestamp: "4"
      )
    }
    let(:response) { double("response", body: :json) }

    it "appends the auth parameters" do
      expect(rest_client).to receive(:get).with("1/comics?ts=4&apikey=2&hash=248e844336797ec98478f85e7626de4a")
      api.find
    end

    it "returns json" do
      allow(rest_client).to receive(:get).and_return(response)
      expect(api.find).to eq(:json)
    end
  end
end
