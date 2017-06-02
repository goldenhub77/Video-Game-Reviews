class VideoGamesController < ApplicationController
  before_action :load_games, except: [:home]

  #welcome page/root page or if user unauthenticated
  def home

  end

  #views all available video games sorted by title
  def index
    if !video_game_params["user_id"].nil?
      @title = "#{current_user.first_name} #{current_user.last_name}'s games"
      user = User.find(video_game_params["user_id"])
      @video_games = user.video_games
    else
      @title = 'Available Games'
    end

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
    params.permit([:user_id])
  end

  def load_games
    @video_games = VideoGame.all
  end
end
