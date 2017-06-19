class Admins::ReviewsController < ApplicationController
  before_action :get_review, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @all_reviews = @user.reviews
  end

  def destroy
    if @review.destroy
      flash[:notice] = "You successfully deleted #{@review.title}"
    else
      flash[:notice] = "Failed to remove #{@review.title}"
    end
    redirect_to admins_path
  end

  # def show
  #   @review = Review.find(get_review_params[:id])
  #   @game = @review.video_game
  # end
  #
  # def edit
  #   @review_for_form = Review.find(get_review_params[:id])
  # end
  #
  # def new
  #   @game = VideoGame.find(get_review_params[:video_game_id])
  #   @review_for_form = Review.new
  # end
  #
  # def create
  #   @game = VideoGame.find(get_review_params[:video_game_id])
  #   @review_for_form = @game.reviews.new(post_review_params)
  #   @review_for_form.user_id = current_user.id
  #   if @review_for_form.save
  #     flash[:notice] = "You successfully added #{@review_for_form.title} "
  #     redirect_back(fallback_location: video_game_path(@game))
  #   else
  #     render :new
  #   end
  # end
  #
  # def update
  #   @review_for_form = Review.find(get_review_params[:id])
  #   if @review_for_form.update(post_review_params)
  #     flash[:notice] = "You successfully updated #{@review_for_form.title} "
  #     redirect_back(fallback_location: user_review_path(current_user))
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @review_for_form = Review.find(get_review_params[:id])
  #   @review_for_form.destroy
  #   flash[:notice] = "You successfully deleted #{@review_for_form.title} "
  #   redirect_back(fallback_location: user_reviews_path(current_user))
  # end

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
