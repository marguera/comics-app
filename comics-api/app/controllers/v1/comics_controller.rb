module V1
  class ComicsController < ApplicationController
    def index
      service = ComicsSearchService.new
      results = service.find
      render json: results, status: :ok
    end
  end
end
