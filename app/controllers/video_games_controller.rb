class VideoGamesController < ApplicationController
  before_action :load_games

  def index
    
  end


  protected

  def load_games
    @video_games = VideoGame.all
  end
end
