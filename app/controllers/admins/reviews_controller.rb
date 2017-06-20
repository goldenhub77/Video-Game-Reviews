class Admins::ReviewsController < ApplicationController
  before_action :get_review, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews
  end

  def destroy
    if @review.destroy
      flash[:notice] = "You successfully deleted #{@review.title}"
    else
      flash[:notice] = "Failed to remove #{@review.title}"
    end
    redirect_to admins_path
  end

  protected

  def get_review
    @review = Review.find(get_review_params[:id])
  end

  def get_review_params
    params.permit(:id, :search, :user_id, :video_game_id, :review_search)
  end

  def post_review_params
    ReviewDecanter.decant(params[:review])
  end
end
