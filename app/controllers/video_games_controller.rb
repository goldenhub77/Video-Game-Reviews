class VideoGamesController < ApplicationController
  before_action :find_video_game, only: [:show, :edit, :update, :destroy]

  #welcome page/root page or if user unauthenticated
  def home

  end

  def index
    if !get_video_game_params[:user_id].nil?
      authorize_owner!
      if get_video_game_params[:search]
        @all_video_games = current_user.video_games.search(params[:search]).order("created_at DESC")
        if @all_video_games.empty?
          no_results!(get_video_game_params[:search])
        end
      else
        @all_video_games = current_user.video_games.order("created_at DESC")
      end
    else
      @all_video_games = VideoGame.order('created_at DESC')
      if get_video_game_params[:search]
        @all_video_games = VideoGame.search(params[:search]).order("created_at DESC")
        if @all_video_games.empty?
          no_results!(get_video_game_params[:search])
        end
      else
        @all_video_games = VideoGame.all.order("created_at DESC")
      end
    end
  end

  def show
    if get_video_game_params[:search].nil?
      @all_reviews = @game.reviews.order('created_at DESC')
    else
      @all_reviews = @game.reviews.search(params[:search]).order("created_at DESC")
    end
  end

  def edit

  end

  def new
    @game = VideoGame.new
  end

  def create
    @game = VideoGame.new(VideoGameDecanter.decant(params[:video_game]))
    @game.user_id = current_user.id

    if @game.save
      flash[:notice] = "You successfully added #{@game.title} "
      redirect_back(fallback_location: video_game_path(@game))
    else
      render :new
    end
  end

  def update
    @game.update_attributes(post_video_game_params)
    if @game.save
      flash[:notice] = "You successfully updated #{@game.title} "
      redirect_back(fallback_location: user_video_games_path(@game))
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    flash[:notice] = "You successfully deleted #{@game.title} "
    redirect_to user_video_games_path(@game)
  end

  protected

  def find_video_game
    @game = VideoGame.find(get_video_game_params[:id])
  end

  def get_video_game_params
    params.permit(:id, :user_id, :search, :video_game_id)
  end

  def post_video_game_params
    result = params.require(:video_game).permit(:id, :title, :developer, :description, :genre_id, :release_date, :rating, platforms: [])
    VideoGameDecanter.decant(result)
  end
end
