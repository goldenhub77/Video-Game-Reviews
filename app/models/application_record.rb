class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def html_platforms
    "#{platforms.map { |platform| platform.name }.join(", ")}"
  end
end
