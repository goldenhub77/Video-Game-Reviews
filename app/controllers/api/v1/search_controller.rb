class Api::V1::SearchController < Api::V1::ApiController
  include ApplicationHelper

  def index
    if ajax_params[:reviewsPresent].nil? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = VideoGame.search(ajax_params[:searchQuery])
      end
    elsif ajax_params[:reviewsPresent].nil? && ajax_params[:url].include?('user')
        @objects = current_user.video_games.search(ajax_params[:searchQuery])
    elsif ajax_params[:reviewsPresent].present? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        video_game = VideoGame.find(ajax_params[:videoGameId])
        @objects = video_game.reviews.search(ajax_params[:searchQuery])
      end
    elsif ajax_params[:reviewsPresent].present? && ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = current_user.reviews.search(ajax_params[:searchQuery])
      end
    end
    convert_to_js_ids(@objects)
    load_notice
    action_response
  end

  protected

  def load_notice
    if @js_ids.empty? && ajax_params[:searchQuery] != ""
      @notice = "There are no results matching the term '#{ajax_params[:searchQuery]}'"
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

  def ajax_params
    params.permit(:searchQuery, :videoGameId, :reviewsPresent, :userId, :url, :auth)
  end
end
