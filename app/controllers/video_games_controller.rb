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

  def load_games
    @video_games = VideoGame.all
  end
end
