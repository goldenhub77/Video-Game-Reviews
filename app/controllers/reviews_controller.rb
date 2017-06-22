class ReviewsController < ApplicationController
  before_action :load_reviews, only: [:index]
  before_action :find_review, only: [:show, :edit, :update, :vote, :destroy]
  before_action :find_game, only: [:new, :create]
  before_action :find_review_game, only: [:show, :edit, :update]

  def index
    if !get_review_params[:video_game_id].nil? && get_review_params[:review_search].nil?
      @game = VideoGame.find(get_review_params[:video_game_id])
      if get_review_params[:search]
        @reviews = Review.search(params[:search])
        if @reviews.empty?
          no_results!(get_review_params[:search])
        end
      end
    elsif !get_review_params[:user_id].nil? || (get_review_params[:video_game_id] && !get_review_params[:review_search].nil?)
      authorize_owner!
      load_user
      if get_review_params[:search]
        @reviews = @user.reviews.search(params[:search])
        if @reviews.empty?
          no_results!(get_review_params[:search])
        end
      else
        @reviews = @user.reviews.order("created_at DESC")
      end
    end
  end

  def show
  end

  def edit
  end

  def new
    @review = Review.new
  end

  def create
    @review = @game.reviews.new(post_review_params)
    @review.user_id = current_user.id
    if @review.save
      success_notice!(@review.title, "created")
      redirect_to video_game_path(@game)
    else
      render :new
    end
  end

  def update
    @review.update_attributes(post_review_params)
    if @review.save
      success_notice!(@review.title, "updated")
      redirect_back(fallback_location: user_review_path(current_user))
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    success_notice!(@review.title, "deleted")
    redirect_to user_reviews_path(current_user)
  end

  def vote
    review_vote = ReviewVote.find_or_initialize_by(user_id: current_user.id, review_id: @review.id)
    review_vote.vote = params[:vote].to_i
    review_vote.save!
    respond_to do |response|
      response.js {
        @html = vote_html(@review)
        up_vote = @review.voted_thumbs_up?(current_user)
        down_vote = @review.voted_thumbs_down?(current_user)
        render json: {
          id: ajax_params[:id],
          html: @html,
          downVote: down_vote,
          upVote: up_vote
        }
      }
      response.html { redirect_back(fallback_location: video_game_path(@review.video_game)) }
    end
  end

  protected

  def load_reviews
    @reviews = Review.order('created_at DESC')
  end

  def load_user
    @user = User.find(get_review_params[:user_id])
    if @user.id != current_user.id && current_user.admin?
      @title = "#{@user.full_name}'s Reviews (#{@user.email})"
    else
      @title = "My Reviews"
    end
  end

  def find_review
    @review = Review.find(get_review_params[:id])
  end

  def find_game
    @game = VideoGame.find(get_review_params[:video_game_id])
  end

  def find_review_game
    @game = @review.video_game
  end

  def ajax_params
    params.permit(:id, :auth)
  end

  def get_review_params
    params.permit(:id, :search, :user_id, :video_game_id, :review_search)
  end

  def vote_html(resource)
    "<p>#{resource.total_rating}</p>
     <p>#{resource.review_helpful?}</p>"
  end

  def post_review_params
    permitted = params.require(:review).permit(:id, :vote, :title, :review, :rating, :video_game_id, :platforms)
    if permitted[:platforms].present?
      permitted[:platforms] = Platform.where('id = ?', permitted[:platforms])
    else
      permitted[:platforms] = []
    end
    permitted
  end
end
