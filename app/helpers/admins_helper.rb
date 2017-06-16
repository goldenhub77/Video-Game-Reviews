module AdminsHelper

  def admins_controller?
    is_a?(::AdminsController)
  end
end
