class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:update, :destroy, :create, :new]



  def index
    @meals = Meal.all
    if params[:search]
    @meal = Meal.search(params[:search]).order("created_at DESC")
    else
    @meals = Meal.all.order('created_at DESC').page(params[:page])
    end
    @markers = []
    @meals.each do |meal|
      restaurant = meal.restaurant
      markers = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
        marker.lat restaurant.latitude
        marker.lng restaurant.longitude
      end
      @markers << markers
    end

  end

  def show
    @meal = Meal.find(params[:id])
    @markers = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
      marker.lat @meal.restaurant.latitude
      marker.lng @meal.restaurant.longitude
    end
    @restaurant_coordinates = [{ lat: @meal.restaurant.latitude, lng: @meal.restaurant.longitude }]
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = @restaurant.meals.create(params_meal)
    if @meal.save
      redirect_to restaurant_meals_path(@restaurant, @meal)
    else
       render :new
     end
  end

  def edit
    @meal = Meal.find(params[:id])#DRY with set_meal
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.update(params_meal)
    if @meal.save
    redirect_to restaurant_meals_path(@restaurant, @meal)
    else
    render :edit
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    if @meal.delete
       redirect_to user_path(current_user)
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
