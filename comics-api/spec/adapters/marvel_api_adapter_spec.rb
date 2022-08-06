require 'rails_helper'

RSpec.describe "MarvelApiAdapter" do

  let(:api) { MarvelApiAdapter.new }

  let(:auth) {
    { ts: '1', 
      apikey: '123', 
      hash: '41166ef71feca5c492e2dad09f42e685' }
  }

  before do
    api.instance_variable_set(:@public_key, "123")
    api.instance_variable_set(:@private_key, "456")
    api.instance_variable_set(:@timestamp, 1)
  end
  
  before do
    stub_request(:get, /#{MarvelApiAdapter::ENDPOINT}/)
      .to_return({ body: '{"a":"b"}' })
  end

  describe "#find_comics" do

    context "with successfull request" do

      it "appends the auth parameters" do
        api.find_comics
        expect(a_request(:get, "#{MarvelApiAdapter::ENDPOINT}/comics")
          .with(query: hash_including(auth))).to have_been_made 
      end

      it "appends the search params" do
        search_params = { character: '1,2,3' }
        api.find_comics(search_params)
        expect( a_request(:get, "#{MarvelApiAdapter::ENDPOINT}/comics")
          .with(query: hash_including(search_params))).to have_been_made 
      end

      it "returns the response string" do
        expect(api.find_comics).to be_a(String)
        expect(api.find_comics).to eq('{"a":"b"}')
      end
    end
    
    context "with invalid request" do
      before do
        stub_request(:get, /#{MarvelApiAdapter::ENDPOINT}/)
          .to_raise("request error")
      end

      it "raises an error" do
        expect { api.find_comics }.to raise_error("request error")
      end
    end
  end

  
  describe "#find_characters" do

    before do
      api.instance_variable_set(:@public_key, "123")
      api.instance_variable_set(:@private_key, "456")
      api.instance_variable_set(:@timestamp, 1)
    end

    context "with successfull request" do
      before do
        stub_request(:get, /#{MarvelApiAdapter::ENDPOINT}/)
          .to_return({ body: '{"a":"b"}' })
      end

      it "appends the auth parameters" do
        api.find_characters
        expect(a_request(:get, "#{MarvelApiAdapter::ENDPOINT}/characters")
          .with(query: hash_including(auth))).to have_been_made 
      end

      it "appends the search params" do
        search_params = { name: 'hero-name' }
        api.find_characters(search_params)
        expect(a_request(:get, "#{MarvelApiAdapter::ENDPOINT}/characters")
          .with(query: hash_including( search_params ))).to have_been_made 
      end

      it "returns the response string" do
        expect(api.find_characters).to be_a(String)
        expect(api.find_characters).to eq('{"a":"b"}')
      end
    end
    
    context "with invalid request" do
      before do
        stub_request(:get, /#{MarvelApiAdapter::ENDPOINT}/)
          .to_raise("request error")
      end

      it "raises an error" do
        expect { api.find_characters }.to raise_error("request error")
      end
    end
  end
end
