class UserReviewsController < ApplicationController
  # before_action :check_user

  def index
    @title = "My Reviews"
    if params[:search]
      @all_reviews = current_user.reviews.search(params[:search]).order("created_at DESC")
      if @all_reviews.empty?
        flash[:notice] = "There are no reviews containing the term '#{params[:search]}'"
      end
    else
      @all_reviews = current_user.reviews.order("created_at DESC")
    end
  end

  def show
    @title = "Review"
    @review = Review.find(review_params[:id])
  end

  def edit
    @title = "Edit"
    @review_for_form = Review.find(review_params[:id])
  end

  protected

  def review_params
    results = params.permit(:id)
    ReviewDecanter.decant(results)
  end

  def check_user
    if current_user.id != video_game_params['user_id'].to_i
      redirect_to user_games_path
    end
  end
end
