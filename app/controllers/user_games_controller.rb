class UserGamesController < ApplicationController
  # before_action :check_user

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

  protected

  def video_game_params
    params.permit([:user_id])
  end

  def check_user
    if current_user.id != video_game_params['user_id'].to_i
      redirect_to user_games_path
    end
  end
end
