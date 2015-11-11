class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:show, :update, :destroy, :create, :index, :new]


  def index
    @meals = Meal.all.order('created_at DESC').page(params[:page])
    @markers = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
    end
  end

  def show
    @meal = Meal.find(params[:id])
    @restaurant_coordinates = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = @restaurant.meals.create(params_meal)
    if @meal.save
      redirect_to restaurant_meals_path(@meal)
    else
       render :new
     end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.update(params_meal)
    if @meal.save
    redirect_to restaurant_meal_path(@restaurant.id)
    else
    render :edit
    end
  end

  def destroy
    if @meal.delete
      redirect_to meals_path
    else
      render :destroy
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])

  end

  def params_meal
    params.require(:meal).permit(:name, :description, :price, :quantity, :picture, :starting_date, :take_away_noon_starts_at, :take_away_evening_starts_at, :take_away_noon_ends_at, :take_away_evening_ends_at, :restaurant_id)
  end

end
