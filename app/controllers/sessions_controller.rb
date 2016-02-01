class SessionsController < ApplicationController
before_action :navbar_choice




  def navbar_choice
    @navbar_other = true
  end

end
