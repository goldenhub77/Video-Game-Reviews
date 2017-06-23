class AdminsController < ApplicationController
  include ApplicationHelper
  before_action :load_objects, only: [:index]

  def index
    if get_admin_params[:review_search]
      @reviews = Review.search(get_admin_params[:review_search])
      load_notice(@reviews, get_admin_params[:review_search])
    end
    if get_admin_params[:video_game_search]
      @all_video_games = VideoGame.search(get_admin_params[:video_game_search])
      load_notice(@reviews, get_admin_params[:video_game_search])
    end
    if get_admin_params[:user_search]
      @all_users = User.search(get_admin_params[:user_search])
      load_notice(@all_users, get_admin_params[:user_search])
    end
    load_js_ids
    action_response
  end


  protected

  def load_objects
    @all_video_games = VideoGame.all
    @reviews = Review.all
    @all_users = User.all
  end

  def load_js_ids
    @js_video_games = convert_to_js_ids(@all_video_games)
    @js_reviews = convert_to_js_ids(@reviews)
    @js_users = convert_to_js_ids(@all_users)
  end

  def load_notice(obj, query)
    if obj.empty? && query != ""
      @notice = "There are no results matching the term '#{query}'"
    end
  end

  def convert_to_js_ids(objs)
    @js_ids = []
    @obj_type = "#{objs.model_name.element.gsub("_", "-")}"
    objs.each do |obj|
      @js_ids << "#{@obj_type}-table-row-#{obj.id}"
    end
    [@js_ids, @obj_type]
  end

  def action_response
    respond_to do |response|
      response.js { render json: {
          jsReviews: { ids: @js_reviews[0], type: @js_reviews[1]},
          jsVideoGames: { ids: @js_video_games[0], type: @js_video_games[1] },
          jsUsers: { ids: @js_users[0], type: @js_users[1] },
          notice: @notice
        }
      }
      response.html { render :index }
    end
  end

  def get_admin_params
    params.permit(:review_search, :video_game_search, :user_search, :auth)
  end
end
