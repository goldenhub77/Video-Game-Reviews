class Api::V1::SearchController < Api::V1::ApiController

  def video_games
    if ajax_params[:reviewsPresent].nil? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = VideoGame.search(ajax_params[:searchQuery]).order("created_at DESC")
      end
    elsif ajax_params[:reviewsPresent].nil? && ajax_params[:url].include?('user')
        @objects = current_user.video_games.search(ajax_params[:searchQuery]).order("created_at DESC")
    elsif !ajax_params[:reviewsPresent].nil? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        video_game = VideoGame.find(ajax_params[:videoGameId])
        @objects = video_game.reviews.search(ajax_params[:searchQuery]).order("created_at DESC")
      end
    end

    if @objects.empty? && ajax_params[:searchQuery] != ""
      @notice = "There are no results containing the term '#{ajax_params[:searchQuery]}'"
    end
    respond_to do |response|
      response.js { render json: {
          objects: @objects,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def reviews
    if !ajax_params[:reviewsPresent].nil? && ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = current_user.reviews.search(ajax_params[:searchQuery]).order("created_at DESC")
      end
    end
    if @objects.empty? && ajax_params[:searchQuery] != ""
      @notice = "There are no results containing the term '#{ajax_params[:searchQuery]}'"
    end
    respond_to do |response|
      response.js { render json: {
          objects: @objects,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  protected

  def ajax_params
    params.permit(:searchQuery, :videoGameId, :reviewsPresent, :userId, :url)
  end
end
