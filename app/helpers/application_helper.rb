module ApplicationHelper

  def object_date_joined(object)
    object.created_at.strftime('%-m/%-d/%Y')
  end

  def user_owns(resource)
    resource.user.id == current_user.id
  end
end
