class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authorize_owner!
    unless self.controller_path == 'devise/registrations' or self.controller_path == 'devise/sessions'
      begin
        resource = current_user.send(self.controller_path).where('id = ?', params[:id])
        if !current_user.is_admin? and resource.empty?
          redirect_to user_video_games_path(current_user.id)
        else
          return true
        end
      rescue NoMethodError => message
        puts message
        return false
      end
    end
  end

  def authorize_admin!
    if current_user.nil? or !current_user.is_admin?
      redirect_back(fallback_location: root_path, message: "You are not authorized to view this resource.")
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
