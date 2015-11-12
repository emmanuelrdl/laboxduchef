class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy ]
  before_action :set_meal, only: [ :edit, :update, :destroy]



  def index

    @meals = Meal.all
    when_group = params[:when_group].to_date
    if when_group
      @meals = @meals.where("starting_date <= ?", when_group).order("created_at DESC")
    else
      @meals = Meal.all.order('created_at DESC').page(params[:page])
    end
    price_group = params[:price_group].to_i
    if price_group
      @meals = @meals.where("price <= ?", price_group).order("created_at DESC")
    else
      @meals = Meal.all.order('created_at DESC').page(params[:page])
    end

    @markers = Gmaps4rails.build_markers(@meals) do |meal, marker|
      marker.lat meal.restaurant.latitude
      marker.lng meal.restaurant.longitude

    end
  end

  def show
    @meal = Meal.find(params[:id])
    @restaurant_coordinates = [{ lat: @meal.restaurant.latitude, lng: @meal.restaurant.longitude }]
  end


  def edit
  end

  def update
     @meal.update(params_meal)
    if @meal.save
    redirect_to user_path(current_user)
    else
    render :edit
    end
  end


  def new
    @meal = Meal.new
  end


  def create
    @meal = @restaurant.meals.create(params_meal)
    if @meal.save
      redirect_to user_path(current_user)
    else
      render :new
     end
  end



  def destroy
    @meal = @restaurant.meals.find(params[:id])
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

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def params_meal
    params.require(:meal).permit(:name, :description, :price, :quantity, :picture, :starting_date, :take_away_noon_starts_at, :take_away_evening_starts_at, :take_away_noon_ends_at, :take_away_evening_ends_at, :restaurant_id)
  end

end
