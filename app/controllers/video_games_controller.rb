class VideoGamesController < ApplicationController
  before_action :load_games, except: [:home]

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

  end

  #create new video game
  def new
    @new_video_game = VideoGame.new
  end

  def create
    @new_video_game = VideoGame.new(create_video_params)
    @new_video_game.user_id = current_user.id
    if @new_video_game.save
      flash[:notice] = "You successfully added #{@new_video_game.title} "
      redirect_to root_path
    else
      render :new
    end
  end

  #post request of edited video game
  def update

  end

  #delete request to remove video game
  def destroy

  end

  protected

  def video_game_params
    params.permit(:id)
  end

  def create_video_params
    params.require(:video_game).permit(:title, :description, :developer, :genre, :release_date, :rating, platforms: [])
  end

  def load_games
    @video_games = VideoGame.all
  end
end
