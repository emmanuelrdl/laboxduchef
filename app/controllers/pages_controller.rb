class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @meals = Meal.all
    @restaurant = Restaurant.all
  end

  def service
  end

  def fonctionnement
  end

  def contact
  end
end
