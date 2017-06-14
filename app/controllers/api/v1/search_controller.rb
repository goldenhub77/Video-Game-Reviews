class Api::V1::SearchController < Api::V1::ApiController

  def all_games
    if params[:search]
      @all_video_games = VideoGame.search(params[:search]).order("created_at DESC")
    else
      @all_video_games = VideoGame.all.order("created_at DESC")
    end
    if @all_video_games.empty?
      @notice = "There are no games containing the term '#{params[:search]}'"
    end
    respond_to do |response|
      response.js { render json: {
          objects: @all_video_games,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def user_games
    @all_video_games = current_user.video_games
    if params[:search]
      @all_video_games = current_user.video_games.search(params[:search]).order("created_at DESC")
    else
      @all_video_games = current_user.video_games.all.order("created_at DESC")
    end
    if @all_video_games.empty?
      @notice = "There are no games containing the term '#{params[:search]}'"
    end
    respond_to do |response|
      response.js { render json: {
          objects: @all_video_games,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def user_reviews
    if params[:search]
      @all_reviews = current_user.reviews.search(params[:search]).order("created_at DESC")
    else
      @all_reviews = current_user.reviews.all.order("created_at DESC")
    end
    if @all_reviews.empty?
      @notice = "There are no reviews containing the term '#{params[:search]}'"
    end
    respond_to do |response|
      response.js { render json: {
          objects: @all_reviews,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def game_page
    video_game = VideoGame.find(params[:id])
    if params[:search]
      @all_reviews = video_game.reviews.search(params[:search]).order("created_at DESC")
    else
      @all_reviews = video_game.reviews.all.order("created_at DESC")
    end
    if @all_reviews.empty?
      @notice = "There are no reviews containing the term '#{params[:search]}'"
    end
    respond_to do |response|
      response.js { render json: {
          objects: @all_reviews,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end
end
