module V1
  class ComicsController < ApplicationController
    def index
      comics  = comics_search.search_comics(search_params)
      likes   = comics_likes.get_likes_from_comics(1, comics)
      result  = comics_likes.enhance_comics_with_likes(comics, likes)
      render json: result, status: :ok
    end

    def like
      comics_likes.increment_likes_count(comic_id: params[:id])
      render nothing: true, status: :ok
    end

    private 

      def comics_search
        @comics_search ||= ComicsSearchService.new
      end

      def comics_likes
        @comics_likes ||= ComicsLikesService.new
      end

      def search_params
        params.permit(:character)
      end
  end
end
