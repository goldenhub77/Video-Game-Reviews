class AdminsController < ApplicationController
  include ApplicationHelper
  def index
    if get_admin_params[:review_search].nil?
      @all_reviews = Review.all
      @js_reviews = []
      @all_reviews.each do |review|
        @js_reviews << { reviewPublished: object_date_joined(review), game: review.video_game, review: review, fullName: review.user.full_name, user: review.user }
      end
    else
      @all_reviews = Review.search(get_admin_params[:review_search])
      @js_reviews = []
      @all_reviews.each do |review|
        @js_reviews << { reviewPublished: object_date_joined(review), game: review.video_game, review: review, fullName: review.user.full_name, user: review.user }
      end
      if @all_reviews.empty? or @js_reviews.empty?
        @review_notice = "No reviews matching #{get_admin_params[:review_search]}"
      end
    end
    if get_admin_params[:video_game_search].nil?
      @all_video_games = VideoGame.all
      @js_video_games = []
      @all_video_games.each do |game|
        @js_video_games << { gamePublished: object_date_joined(game), game: game, user: game.user }
      end
    else
      @all_video_games = VideoGame.search(get_admin_params[:video_game_search])
      @js_video_games = []
      @all_video_games.each do |game|
        @js_video_games << { gamePublished: object_date_joined(game), game: game, user: game.user }
      end
      if @all_video_games.empty? or @js_video_games.empty?
        @game_notice = "No video games matching #{get_admin_params[:video_game_search]}"
      end
    end
    if get_admin_params[:user_search].nil?
      @all_users = User.all
      @js_users = []
      @all_users.each do |user|
        @js_users << { userJoined: object_date_joined(user), fullName: user.full_name, user: user, videoGameCount: user.video_games.count, reviewCount: user.reviews.count }
      end
    else
      @all_users = User.search(get_admin_params[:user_search])
      @js_users = []
      @all_users.each do |user|
        @js_users << { userJoined: object_date_joined(user), fullName: user.full_name, user: user, videoGameCount: user.video_games.count, reviewCount: user.reviews.count }
      end
      if @all_users.empty? or @js_users.empty?

        @user_notice = "No users matching #{get_admin_params[:user_search]}"
      end
    end

    respond_to do |response|
      response.js { render json: {
          videoGames: { objects: @js_video_games, notice: @game_notice },
          users: { objects: @js_users, notice: @user_notice },
          reviews: { objects: @js_reviews, notice: @review_notice }
        }
      }
      response.html { render :index }
    end
  end


  protected

  def get_admin_params
    params.permit(:review_search, :video_game_search, :user_search)
  end
end
