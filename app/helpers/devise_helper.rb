module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
    if resource.errors.count == 1
      error_text = 'error'
    else
      error_text = 'errors'
    end
    sentence = "#{resource.errors.count} #{error_text} in #{resource.class.model_name.human.downcase} form."
    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <div>#{messages}</div>
    </div>
    HTML
    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
