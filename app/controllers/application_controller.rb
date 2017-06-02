class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]
  before_action :configure_permitted_parameters, if: :devise_controller?


  def authorize_admin!
    if current_user.nil? or !current_user.is_admin?
      flash[:notice] = "You are not authorized to view this resource."
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
