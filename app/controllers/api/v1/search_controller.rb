class Api::V1::SearchController < Api::V1::ApiController

  def videos
    @all_video_games = VideoGame.all
    if params[:search]
      @all_video_games = VideoGame.search(params[:search]).order("created_at DESC")
    else
      @all_video_games = VideoGame.all.order("created_at DESC")
    end
    respond_to do |response|
      response.js { render json: @all_video_games }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def reviews

  end
end
