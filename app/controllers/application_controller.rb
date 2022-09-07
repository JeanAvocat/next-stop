class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :define_nickname, if: :user_signed_in?
  before_action :initiate_score, if: :user_signed_in?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name random_nickname social_media score])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def define_nickname
    return unless current_user.random_nickname.nil?
    current_user.random_nickname = current_user.set_nickname
    current_user.save
  end

  def initiate_score
    return unless (current_user.score.nil? || current_user.score.zero?)
    current_user.score = 0
    current_user.save
  end
end
