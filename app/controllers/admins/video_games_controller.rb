class Admins::VideoGamesController < ApplicationController

  #welcome page/root page or if user unauthenticated
  def home

  end

  def index
    @user = User.find(params[:user_id])
    @all_video_games = @user.video_games
  end

  def show
    if !get_video_game_params[:search].nil?
      @game = VideoGame.find(get_video_game_params[:video_game_id])
    else
      @game = VideoGame.find(get_video_game_params[:id])
    end
    if get_video_game_params[:search].nil?
      @all_reviews = @game.reviews.order('created_at DESC')
    else
      @all_reviews = @game.reviews.search(params[:search]).order("created_at DESC")
    end
  end

  def edit
    @game_for_form = VideoGame.find(get_video_game_params[:id])
  end

  def new
    @game_for_form = VideoGame.new
  end

  def create
    @game_for_form = VideoGame.new(VideoGameDecanter.decant(params[:video_game]))
    @game_for_form.user_id = current_user.id

    if @game_for_form.save
      flash[:notice] = "You successfully added #{@game_for_form.title} "
      redirect_back(fallback_location: video_game_path(@game_for_form))
    else
      render :new
    end
  end

  def update
    @game_for_form = VideoGame.find(get_video_game_params[:id])
    @game_for_form.update_attributes(post_video_game_params)
    if @game_for_form.save
      flash[:notice] = "You successfully updated #{@game_for_form.title} "
      redirect_back(fallback_location: user_video_games_path(@game_for_form))
    else
      render :edit
    end
  end

  def destroy
    @game_for_form = VideoGame.find(get_video_game_params[:id])
    @game_for_form.destroy
    flash[:notice] = "You successfully deleted #{@game_for_form.title} "
    redirect_back(fallback_location: user_video_games_path(@game_for_form))
  end

  protected

  def get_video_game_params
    params.permit(:id, :user_id, :search, :video_game_id)
  end

  def post_video_game_params
    result = params.require(:video_game).permit(:id, :title, :developer, :description, :genre_id, :release_date, :rating, platforms: [])
    VideoGameDecanter.decant(result)
  end
end
