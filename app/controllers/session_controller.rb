class SessionController < ApplicationController

  def after_sign_in_path_for(resource)
    redirect_to root_path if resource.restaurant_owner
  end

end
