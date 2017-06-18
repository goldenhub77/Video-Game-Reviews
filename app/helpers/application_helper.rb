module ApplicationHelper

  def object_date_joined(object, column = nil)
    if column.nil?
      object.created_at.strftime('%-m/%-d/%Y')
    else
      object.send(column).strftime('%-m/%-d/%Y')
    end
  end

  def user_owns(resource)
    resource.user.id == current_user.id
  end
end
