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
        @html = @objects.map { |obj| review_html(obj) }
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
    user_email = nil
    thumbs_up = nil
    thumbs_down = nil
    if ajax_params[:url].include?('reviews')
      game_title = "<h5>Game - #{resource.video_game.title}</h5>"
    end
    if current_user.admin?
      user_email = "<p>#{resource.user.email}</p>"
    end
    if resource.voted_thumbs_up?(current_user)
      thumbs_up = "disabled = 'disabled'"
    end
    if resource.voted_thumbs_down?(current_user)
      thumbs_down = "disabled = 'disabled'"
    end
    "<div class='row'>
      <div class='review-block col-xs-12'>
        <div class='user-data row'>
          <div class='col-xs-2'>
            <p>Published</p>
            <p>#{object_date_joined(resource, :created_at)}</p>
          </div>
          <div class='row'>
            <div class='col-xs-3'>
              <p>Written by: #{resource.written_by?(current_user)}</p>
              #{user_email}
            </div>
          </div>
        </div>
          <h2>Game - #{resource.video_game.title}</h2>
        <h2><a href='/reviews/#{resource.id}'>#{resource.title}</a></h2>
        <p>#{resource.short_review} ...</p>
        <div class='row'>
          <div class='col-xs-4'>
            <div class='badge voting-parameters'>
              <form class='button_to' method='post' action='/reviews/#{resource.id}/vote?vote=1'><button id='up-vote-review-#{resource.id}' #{thumbs_up} class='btn btn-default' type='submit'>
                <i class='fa fa-thumbs-up'></i>
                </button>
                <input type='hidden' name='authenticity_token' value='#{ajax_params[:auth]}'>
              </form>
              <form class='button_to' method='post' action='/reviews/#{resource.id}/vote?vote=-1'><button id='down-vote-review-#{resource.id}' #{thumbs_down} class='btn btn-default' type='submit'>
                <i class='fa fa-thumbs-down'></i>
                </button><input type='hidden' name='authenticity_token' value='#{ajax_params[:auth]}'>
              </form>
              <p>#{resource.total_rating}%</p>
              <p>#{resource.review_helpful?}</p>
            </div>
          </div>
        </div>
        <p class='review_platforms'>Platform: #{resource.html_platforms}</p>
      </div>
    </div>"
  end


  def video_game_html(resource)
    image = ActionController::Base.helpers.image_tag('video-game-image-placeholder.jpg', alt: 'default video game image')
    "<div class='video-game-block col-sm-12 col-md-5 col-lg-5'>
      <h4><a href='/video_games/#{resource.id}'>#{resource.title}</a></h4>
      <p>#{resource.developer}</p>
      #{image}
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
