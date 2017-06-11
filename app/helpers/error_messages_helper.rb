module ErrorMessagesHelper
  def error_messages(resource)
    return "" unless error_messages?(resource)

    messages = resource.errors.full_messages.map do |msg|
      if msg != "Genre must exist"
        content_tag(:p, msg)
      end
    end
    messages = messages.join
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

  def error_messages?(resource)
    !resource.errors.empty?
  end
end
