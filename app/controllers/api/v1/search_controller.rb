class Api::V1::SearchController < Api::V1::ApiController
  include ApplicationHelper

  def index
    if search_params[:review_present].nil? && !search_params[:url].include?('user')
      if search_params[:search]
        @objects = VideoGame.search(search_params[:search])
      end
    elsif search_params[:review_present].nil? && search_params[:url].include?('user')
        @objects = current_user.video_games.search(search_params[:search])
    elsif search_params[:review_present].present? && !search_params[:url].include?('user')
      if search_params[:search]
        video_game = VideoGame.find(search_params[:video_game_id])
        @objects = video_game.reviews.search(search_params[:search])
      end
    elsif search_params[:review_present].present? && search_params[:url].include?('user')
      if search_params[:search]
        @objects = current_user.reviews.search(search_params[:search])
      end
    end
    convert_to_js_ids(@objects)
    load_notice
    action_response
  end

  protected

  def load_notice
    if @js_ids.empty? && search_params[:search] != ""
      @notice = "There are no results matching the term '#{search_params[:search]}'"
    end
  end

  def convert_to_js_ids(objs)
    @js_ids = []
    @obj_type = "#{objs.model_name.element.gsub("_", "-")}"
    objs.each do |obj|
      @js_ids << "#{@obj_type}-div-#{obj.id}"
    end
    @js_ids
  end

  def action_response
    respond_to do |response|
      response.js { render json: {
          jsObjIds: @js_ids,
          objType: @obj_type,
          notice: @notice
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def search_params
    params.permit(:search, :video_game_id, :review_present, :user_id, :url)
  end
end
