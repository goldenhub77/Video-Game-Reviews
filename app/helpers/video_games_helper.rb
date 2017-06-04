module VideoGamesHelper
  def video_game_error_messages!
    return "" unless video_game_error_messages?

    messages = @new_video_game.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
    if @new_video_game.errors.count == 1
      error_text = 'error'
    else
      error_text = 'errors'
    end
    sentence = "#{@new_video_game.errors.count} #{error_text} in #{@new_video_game.class.model_name.human.downcase} form."
    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <div>#{messages}</div>
    </div>
    HTML
    html.html_safe
  end

  def video_game_error_messages?
    !@new_video_game.errors.empty?
  end

end
