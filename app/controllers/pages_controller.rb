class PagesController < ApplicationController
  def home
    @meals = Meal.all
    @restaurant = Restaurant.all
  end

  def service
  end

  def about
  end

  def contact
  end
end
