class PagesController < ApplicationController
  def home
    @meals = Meal.all
    @restaurant = Restaurant.all
  end
end
