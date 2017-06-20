class Admins::VideoGamesController < ApplicationController
  before_action :get_video_game, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @all_video_games = @user.video_games
  end

  def destroy
    if @video_game.destroy
      flash[:notice] = "You successfully deleted #{@video_game.title}"
    else
      flash[:notice] = "Failed to remove #{@video_game.title}"
    end
    redirect_to admins_path
  end

  protected

  def get_video_game
    @video_game = VideoGame.find(get_video_game_params[:id])
  end

  def get_video_game_params
    params.permit(:id, :user_id, :search, :video_game_id)
  end

  def post_video_game_params
    result = params.require(:video_game).permit(:id, :title, :developer, :description, :genre_id, :release_date, :rating, platforms: [])
    VideoGameDecanter.decant(result)
  end
end
