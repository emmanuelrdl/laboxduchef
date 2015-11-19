class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show, :home]
  include Pundit

  # after_action :verify_authorized, except: :index, unless: :devise_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end


  def default_url_options
  if Rails.env.production?
    { host: 'laboxduchef.herokuapp.com' }
  else
    { host: ENV['HOST'] || 'localhost:3000' }
  end
end

end
