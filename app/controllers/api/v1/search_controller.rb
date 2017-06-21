class Api::V1::SearchController < Api::V1::ApiController

  include ApplicationHelper
  def index
    if ajax_params[:reviewsPresent].nil? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = VideoGame.search(ajax_params[:searchQuery]).order("created_at DESC")
        @url = "/video_games"
        @html = @objects.map { |obj| video_game_html(obj) }
      end
    elsif ajax_params[:reviewsPresent].nil? && ajax_params[:url].include?('user')
        @objects = current_user.video_games.search(ajax_params[:searchQuery]).order("created_at DESC")
        @url = "/video_games"
        @html = @objects.map { |obj| video_game_html(obj) }
    elsif ajax_params[:reviewsPresent].present? && !ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        video_game = VideoGame.find(ajax_params[:videoGameId])
        @objects = video_game.reviews.search(ajax_params[:searchQuery]).order("created_at DESC")
        @url = "/reviews"
        @html = @objects.map { |obj| review_html(obj) }
      end
    elsif ajax_params[:reviewsPresent].present? && ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = current_user.reviews.search(ajax_params[:searchQuery]).order("created_at DESC")
        @url = "/reviews"
        @html = @objects.map { |obj| review_html(obj) }
      end
    end
    load_notice
    action_response
  end

  def reviews
    if !ajax_params[:reviewsPresent].nil? && ajax_params[:url].include?('user')
      if ajax_params[:searchQuery]
        @objects = current_user.reviews.search(ajax_params[:searchQuery]).order("created_at DESC")
        @html = @objects.map { |obj| html(obj) }
      end
    end
    load_notice
    action_response
  end

  protected

  def load_notice
    if @objects.empty? && ajax_params[:searchQuery] != ""
      @notice = "There are no results matching the term '#{ajax_params[:searchQuery]}'"
    end
  end

  def action_response
    respond_to do |response|
      response.js { render json: {
          objects: @objects,
          notice: @notice,
          linkUrl: @url,
          html: @html
        }
      }
      response.html { redirect_back(fallback_location: root_path) }
    end
  end

  def review_html(resource)
    game_title = nil
    if ajax_params[:url].include?('reviews')
      game_title = "<h5>Game - #{resource.video_game.title}</h5>"
    end
    "<div class='review-block col-sm-8 col-md-4 col-lg-4'>
      #{game_title}
      <a href='/reviews/#{resource.id}'>#{resource.title}</a>
      <div class='row'>
        <div class='col-sm-12 col-md-12'>
          <span class=' badge voting-parameters'>
            <form class='button_to' method='post' action='/reviews/11/vote?vote=1'><button id='up-vote-review-#{resource.id}' #{resource.voted_thumbs_up?(current_user)} class='btn btn-default' type='submit'>
              <i class='fa fa-thumbs-up'></i>
              </button><input type='hidden' name='authenticity_token' value='mnIwESwma87MLHsP1YtaEmoU3tfxu9f4rHJu2b/G1ve0XbVJOLBkcko8E5HDnI9XFTfG7qSAaRjjexacJCocWw=='></form>
              <p>#{resource.total_rating}</p>
            <form class='button_to' method='post' action='/reviews/11/vote?vote=-1'><button id='down-vote-review-#{resource.id}' #{resource.voted_thumbs_down?(current_user)} class='btn btn-default' type='submit'>
              <i class='fa fa-thumbs-down'></i>
              </button><input type='hidden' name='authenticity_token' value=#{ajax_params[:auth]}></form>
          </span>
        </div>
      </div>
    </div>"
  end

  def video_game_html(resource)
    "<div class='video-game-block col-sm-12 col-md-4 col-lg-3'>
      <h4><a href='/video_games/#{resource.id}'>#{resource.title}</a></h4>
      <p>#{resource.developer}</p>
      <div class='col-sm-6 col-md-6'>
        Release Date:
        <p>#{object_date_joined(resource, :release_date)}</p>
      </div>
      <div class='row'>
        <div class='col-sm-12 col-md-12'>
          <p>#{resource.html_platforms}</p>
        </div>
      </div>
      <span class='rating-parameters'>
        <i class='fa fa-gamepad fa-2x'></i>
        <p>Rating: #{resource.rating_avg}</p>
      </span>
    </div>"
  end

  def ajax_params
    params.permit(:searchQuery, :videoGameId, :reviewsPresent, :userId, :url, :auth)
  end
end
