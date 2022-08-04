require 'rails_helper'

RSpec.describe "Comics", type: :request do
  describe "GET /index" do
    context 'without parameters' do
      before do
        get '/v1/comics'
      end

      it 'returns a 200 response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json' do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it 'returns a valid comics list json' do
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an(Hash)
        expect(json_response["results"]).to be_an(Array)
        comic = json_response["results"].first
        expect(comic).to have_key('id')
        expect(comic).to have_key('title')
        expect(comic).to have_key('thumbnail')
      end
    end
  end
  
end
