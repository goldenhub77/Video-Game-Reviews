class VideoGamesController < ApplicationController
  before_action :load_games, only: [:index]

  #welcome page/root page or if user unauthenticated
  def home

  end

  #views all available video games sorted by title
  def index
    @title = 'Available Games'
  end

  def show
    @game = VideoGame.where(video_game_params).first
  end

  #change existing video game if owner
  def edit
    @game_for_form = VideoGame.find(video_game_params[:id])
  end

  #create new video game
  def new
    @game_for_form = VideoGame.new
  end

  def create
    @game_for_form = VideoGame.new(post_game_params)
    @game_for_form.user_id = current_user.id
    if @game_for_form.save
      flash[:notice] = "You successfully added #{@game_for_form.title} "
      redirect_to root_path
    else
      render :new
    end
  end

  #post request of edited video game
  def update
    @game_for_form = VideoGame.find(video_game_params[:id])
    if @game_for_form.update(post_game_params)
      flash[:notice] = "You successfully updated #{@game_for_form.title} "
      redirect_to root_path
    else
      render :edit
    end
  end

  #delete request to remove video game
  def destroy
    @game_for_form = VideoGame.find(video_game_params[:id])
    @game_for_form.destroy
    redirect_to user_video_games_path(current_user.id) 
  end

  protected

  def video_game_params
    params.permit(:id)
  end

  def post_game_params
    params.require(:video_game).permit(:title, :description, :developer, :genre, :release_date, :rating, platforms: [])
  end

  def load_games
    @all_video_games = VideoGame.all
  end
end
