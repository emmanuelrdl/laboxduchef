class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @meals = Meal.all
    @restaurant = Restaurant.all
  end

  def espace_restaurants
  end

  def fonctionnement
  end


end
