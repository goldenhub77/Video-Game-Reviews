class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :vote]

  def index
    if !get_review_params[:video_game_id].nil? && get_review_params[:review_search].nil?
      @game = VideoGame.find(get_review_params[:video_game_id])
      @all_reviews = Review.order('created_at DESC')
      if get_review_params[:search]
        @all_reviews = Review.search(params[:search]).order("created_at DESC")
        if @all_reviews.empty?
          no_results!(get_review_params[:search])
        end
      else
        @all_reviews = Review.order("created_at DESC")
      end
    elsif !get_review_params[:user_id].nil? || (get_review_params[:video_game_id] && !get_review_params[:review_search].nil?)
      authorize_owner!
      if get_review_params[:search]
        @all_reviews = current_user.reviews.search(params[:search]).order("created_at DESC")
        if @all_reviews.empty?

          no_results!(get_review_params[:search])
        end
      else
        @all_reviews = current_user.reviews.order("created_at DESC")
      end
    end
  end

  def show
    @game = @review.video_game
  end

  def edit
    @review_for_form = Review.find(get_review_params[:id])
  end

  def new
    @game = VideoGame.find(get_review_params[:video_game_id])
    @review_for_form = Review.new
  end

  def create
    @game = VideoGame.find(get_review_params[:video_game_id])
    @review_for_form = @game.reviews.new(post_review_params)
    @review_for_form.user_id = current_user.id
    if @review_for_form.save
      flash[:notice] = "You successfully added #{@review_for_form.title} "
      redirect_back(fallback_location: video_game_path(@game))
    else
      render :new
    end
  end

  def update
    @review_for_form = Review.find(get_review_params[:id])
    if @review_for_form.update(post_review_params)
      flash[:notice] = "You successfully updated #{@review_for_form.title} "
      redirect_back(fallback_location: user_review_path(current_user))
    else
      render :edit
    end
  end

  def destroy
    @review_for_form = Review.find(get_review_params[:id])
    @review_for_form.destroy
    flash[:notice] = "You successfully deleted #{@review_for_form.title} "
    redirect_back(fallback_location: user_reviews_path(current_user))
  end

  def vote
    review_vote = ReviewVote.find_or_initialize_by(user_id: current_user.id, review_id: @review.id)
    review_vote.vote = params[:vote].to_i
    review_vote.save!
    redirect_back(fallback_location: video_game_path(@review.video_game))
  end

  protected

  def find_review
    @review = Review.find(get_review_params[:id])
  end

  def get_review_params
    params.permit(:id, :search, :user_id, :video_game_id, :review_search)
  end

  def post_review_params
    ReviewDecanter.decant(params[:review])
  end
end
