module ApplicationHelper

  def current_user_date_joined
    current_user.created_at.strftime('%-m/%-d/%Y')
  end
end
