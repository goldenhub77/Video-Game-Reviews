class Api::V1::SearchController < Api::V1::ApiController

  def index

  end

  def video_games
    if ajax_params[:reviewsPresent].nil? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = VideoGame.search(ajax_params[:searchQuery]).order("created_at DESC")
      end
    elsif ajax_params[:reviewsPresent].nil? && ajax_params[:url].include?('user')
      @objects = current_user.video_games.search(ajax_params[:searchQuery]).order("created_at DESC")
    elsif !ajax_params[:reviewsPresent].nil? && !ajax_params[:url].include?('user')
      @objects = current_user.reviews.search(ajax_params[:searchQuery]).order("created_at DESC")
    #     @all_video_games = current_user.video_games.order("created_at DESC")
    #   end
    # elsif !get_video_game_params[:video_game_id].nil?
    #   if !get_video_game_params[:search].nil?
    #     @game = VideoGame.find(get_video_game_params[:video_game_id])
    #   else
    #     @game = VideoGame.find(get_video_game_params[:id])
    #   end
    #   if get_video_game_params[:search].nil?
    #     @all_reviews = @game.reviews.order('created_at DESC')
    #   else
    #     @all_reviews = @game.reviews.search(params[:search]).order("created_at DESC")
    #   end
    # else
    #   @title = 'Available Games'
    #   @all_video_games = VideoGame.order('created_at DESC')
    #   if params[:search]
    #     @all_video_games = VideoGame.search(params[:search]).order("created_at DESC")
    #     if @all_video_games.empty?
    #       @notice = "There are no video games matching the term '#{params[:search]}'"
    #     end
    #   else
    #     @all_video_games = VideoGame.all.order("created_at DESC")
    #   end
    end
    if @objects.empty?
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

  protected

  def ajax_params
    params.permit(:searchQuery, :videoGameId, :reviewsPresent, :userId, :url)
  end
end
