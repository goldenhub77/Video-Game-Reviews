class VideoGamesController < ApplicationController

  #welcome page/root page or if user unauthenticated
  def home

  end

  #views all available video games sorted by title
  def index
    @title = 'Available Games'
    @all_video_games = VideoGame.order('created_at DESC')
    if params[:search]
      @all_video_games = VideoGame.search(params[:search]).order("created_at DESC")
      if @all_video_games.empty?
        flash[:notice] = "There are no recipes containing the term '#{params[:search]}'"
      end
    else
      @all_video_games = VideoGame.all.order("created_at DESC")
    end
  end

  def show
    @game = VideoGame.where(video_game_params).first
  end

  def edit
    @game_for_form = VideoGame.find(video_game_params[:id])
    @platform_ids = @game_for_form.platform_ids
  end

  def new
    @game_for_form = VideoGame.new
    @platform_ids = []
  end

  def create
    @game_for_form = VideoGame.new(post_game_params)
    @game_for_form.user_id = current_user.id
    if @game_for_form.save
      flash[:notice] = "You successfully added #{@game_for_form.title} "
      redirect_to root_path
    else
      if post_game_params[:platform_ids].nil?
        @platform_ids = []
      else
        @platform_ids = post_game_params[:platform_ids]
      end
      render :new
    end
  end

  def update
    @game_for_form = VideoGame.find(video_game_params[:id])
    if post_game_params[:platform_ids].nil?
      @platform_ids = []
    else
      @platform_ids = post_game_params[:platform_ids]
    end
    if @game_for_form.update(post_game_params)
      flash[:notice] = "You successfully updated #{@game_for_form.title} "
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @game_for_form = VideoGame.find(video_game_params[:id])
    @game_for_form.destroy
    flash[:notice] = "You successfully deleted #{@game_for_form.title} "
    redirect_to user_video_games_path(current_user.id)
  end

  protected

  def video_game_params
    params.permit(:id)
  end

  def post_game_params
    params.require(:video_game).permit(:title, :description, :developer, :genre_id, :release_date, :rating, platform_ids: [])
  end
end
