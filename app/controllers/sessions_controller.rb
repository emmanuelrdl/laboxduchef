class SessionsController < ApplicationController
before_action :navbar_choice

  def after_sign_in_path_for(resource)
     if resource.restaurant_owner
        redirect_to root_path
    else
        redirect_to root_path
    end
  end

  def navbar_choice
    @navbar_other = true
  end

end
