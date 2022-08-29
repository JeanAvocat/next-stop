class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name phone_number random_nickname social_media score])
  end
end
