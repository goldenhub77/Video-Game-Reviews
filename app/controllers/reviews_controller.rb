class ReviewsController < ApplicationController

  def index
    @title = "Reviews for"
    @game = VideoGame.find(review_params[:video_game_id])
    @all_reviews = Review.order('created_at DESC')
    if params[:search]
      @all_reviews = Review.search(params[:search]).order("created_at DESC")
      if @all_reviews.empty?
        flash[:notice] = "There are no video games matching '#{params[:search]}'"
      end
    else
      @all_reviews = Review.order("created_at DESC")
    end
  end

  def show
    @game = VideoGame.where(review_params).first
    @video_game_review = Review.find(review_params[:id])
  end

  def edit
    @title = "Edit"
    @review_for_form = Review.find(review_params[:id])
  end

  def new
    @title = "Write Review for"
    @game = VideoGame.find(review_params[:video_game_id])
    @review_for_form = Review.new
    # @review_for_form = VideoGame.find(review_params[:video_game_id]).reviews.new
  end

  def create
    @game = VideoGame.find(review_params[:video_game_id])
    @review_for_form = @game.reviews.new(ReviewDecanter.decant(params[:review]))
    @review_for_form.user_id = current_user.id
    if @review_for_form.save
      flash[:notice] = "You successfully added #{@review_for_form.title} "
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @review_for_form = Review.find(review_params[:id])

    if @review_for_form.update(ReviewDecanter.decant(params[:review]))
      flash[:notice] = "You successfully updated #{@review_for_form.title} "
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @review_for_form = Review.find(review_params[:id])
    @review_for_form.destroy
    flash[:notice] = "You successfully deleted #{@review_for_form.title} "
    redirect_to user_video_games_path(current_user.id)
  end

  protected

  def review_params
    params.permit(:id, :video_game_id)
  end
end
