module V1
  class ComicsController < ApplicationController
    def index
      results = { 
        results: [{
          id: 1,
          title: "Superman",
          thumbnail: "image_url" 
        }]
      }
      render json: results, status: :ok
    end
  end
end
