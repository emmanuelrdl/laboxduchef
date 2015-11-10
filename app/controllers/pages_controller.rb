class PagesController < ApplicationController
  def home
    @meals = Meal.all
  end
end
