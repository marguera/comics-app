require 'rails_helper'

RSpec.describe "MarvelApiAdapter" do

  describe "find comics" do

    let(:api) { comics_api_wrapper }

    let(:auth) {
      { ts: '1', 
        apikey: '123', 
        hash: '41166ef71feca5c492e2dad09f42e685' }
    }

    context "with successfull request" do
      before do
        stub_request(:get, /#{MarvelApiAdapter::ENDPOINT}/)
          .to_return({ body: '{"a":"b"}' })
      end

      it "appends the auth parameters" do
        api.find
        expect(a_request(:get, MarvelApiAdapter::ENDPOINT)
          .with(query: auth)).to have_been_made 
      end

      it "returns the response string" do
        expect(api.find).to be_a(String)
        expect(api.find).to eq('{"a":"b"}')
      end
    end
    
    context "with invalid request" do
      before do
        stub_request(:get, /#{MarvelApiAdapter::ENDPOINT}/)
          .to_raise("request error")
      end

      it "raises an error" do
        expect { api.find }.to raise_error("request error")
      end
    end
  end
end
