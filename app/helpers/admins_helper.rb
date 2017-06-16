module AdminsHelper

  def admins_controller?
    is_a?(::AdminsController) or is_a?(::Admins::ReviewsController) or is_a?(::Admins::VideoGamesController)
  end
end
