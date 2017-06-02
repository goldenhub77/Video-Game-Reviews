class UserGamesController < ApplicationController
  before_action :check_user

  def index
    @title = "My games"
    @video_games = current_user.video_games
  end

  protected

  def video_game_params
    params.permit([:user_id])
  end

  def check_user
    if current_user.id != video_game_params['user_id'].to_i
      redirect_to user_video_games_path(current_user.id)
    end
  end
end
