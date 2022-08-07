require 'rails_helper'

RSpec.describe "Comics", type: :request do

  before do 
    Rails.cache.clear
  end

  describe "GET /index" do

    context 'without parameter' do
      it 'returns a 200 response', :vcr do
        get '/v1/comics'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
  
        json = JSON.parse(response.body)
        expect(json['results']).to be_an(Array)
  
        comic = json['results'].first
        expect(comic).to have_key('id')
        expect(comic).to have_key('title')
        expect(comic).to have_key('thumbnail')
        expect(comic).to have_key('likes')
      end
    end

    context 'with valid' do
      it 'page returns 200 response', :vcr do
        get '/v1/comics?page=4'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it 'character returns a 200 response', :vcr do
        get '/v1/comics?character=Hulk'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
    
    context 'with invalid' do
      it 'page returns a 200 response', :vcr do
        get '/v1/comics?page=-3421441414124'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it 'character returns a 200 response', :vcr do
        get '/v1/comics?character=FIESKVLNMSAGSEIOG'
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "POST /index/:id/like" do
    it 'returns a 200 response with comics' do
      post '/v1/comics/1234/like'
      expect(response).to have_http_status(:success)
    end
  end
  
  it 'add like and returns liked' do

    Like.delete_all
    
    get '/v1/comics'
    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq("application/json; charset=utf-8")
    json = JSON.parse(response.body)
    expect(json['results'][0]['liked']).to eq(false)

    post "/v1/comics/#{json['results'][0]['id']}/like"
    expect(response).to have_http_status(:success)

    get '/v1/comics'
    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq("application/json; charset=utf-8")
    json = JSON.parse(response.body)
    expect(json['results'][0]['liked']).to eq(true)
  end
end
