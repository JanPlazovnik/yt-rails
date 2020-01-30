class SearchController < ApplicationController
    def index
        @videos = Video.search(params[:q])
    end
end
