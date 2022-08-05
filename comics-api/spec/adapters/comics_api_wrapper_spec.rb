require 'rails_helper'

RSpec.describe "ComicsApiWrapper" do

  describe "find comics" do
    let(:api) {
      ComicsApiWrapper.new(
        public_key: "123",
        private_key: "456",
        timestamp: 1,
      )
    }
   
    before do
      stub_request(:get, /#{ComicsApiWrapper::ENDPOINT}/)
        .to_return({ body: '{"a":"b"}' })
    end

    it "appends the auth parameters" do
      api.find
      expect(a_request(:get, ComicsApiWrapper::ENDPOINT)
        .with(query: { 
          ts: '1', 
          apikey: '123', 
          hash: '41166ef71feca5c492e2dad09f42e685' 
        })).to have_been_made 
    end

    it "returns the response string" do
      response = api.find
      expect(response).to be_a(String)
      expect(response).to eq('{"a":"b"}')
    end
  end
end
