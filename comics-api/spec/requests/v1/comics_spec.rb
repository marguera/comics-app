require 'rails_helper'

RSpec.describe "Comics", type: :request do

  describe "GET /index" do
    
    context 'without parameters' do

      it 'returns a 200 response with comics', :vcr do
        get '/v1/comics'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json = JSON.parse(response.body)
        expect(json).to be_an(Array)

        comic = json.first
        expect(comic).to have_key('id')
        expect(comic).to have_key('title')
        expect(comic).to have_key('thumbnail')
        expect(comic).to have_key('likes')
      end
    end
  end

  describe "POST /index/:id/like" do

    it 'returns a 200 response with comics', :vcr do
      post '/v1/comics/1234/like'
      expect(response).to have_http_status(:success)
    end
  end
  
end
