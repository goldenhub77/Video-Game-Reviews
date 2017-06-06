module VideoGamesHelper
  def video_game_error_messages!
    return "" unless video_game_error_messages?

    messages = @game_for_form.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
    if @game_for_form.errors.count == 1
      error_text = 'error'
    else
      error_text = 'errors'
    end
    sentence = "#{@game_for_form.errors.count} #{error_text} in #{@game_for_form.class.model_name.human.downcase} form."
    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <div>#{messages}</div>
    </div>
    HTML
    html.html_safe
  end

  def video_game_error_messages?
    !@game_for_form.errors.empty?
  end

end
