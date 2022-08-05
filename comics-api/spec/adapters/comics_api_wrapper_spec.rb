require 'rails_helper'

RSpec.describe "ComicsApiWrapper" do
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
    let(:response) { double("response", body: :json) }

    it "appends the auth parameters" do
      expect(rest_client).to receive(:get).with("u/comics?ts=&apikey=pu&hash=0dea849e9fe91b89b411440f4cc0ae0f")
      api.find
    end

    it "returns json" do
      allow(rest_client).to receive(:get).and_return(response)
      expect(api.find).to eq(:json)
    end
  end
end
