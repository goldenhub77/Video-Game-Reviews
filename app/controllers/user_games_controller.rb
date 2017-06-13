class UserGamesController < ApplicationController

  def index
    @title = "My games"
    if params[:search]
      @all_video_games = current_user.video_games.search(params[:search]).order("created_at DESC")
      if @all_video_games.empty?
        flash[:notice] = "There are no games containing the term '#{params[:search]}'"
      end
    else
      @all_video_games = current_user.video_games.order("created_at DESC")
    end
  end

  def show
    @title = "My games"
    @all_video_games = current_user.video_games.order('created_at DESC')
  end
end
