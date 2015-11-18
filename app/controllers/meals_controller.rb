class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy ]
  before_action :set_meal, only: [ :edit, :update, :destroy]



  def index
    @meal = Meal.new
    @meals = Meal.all.page(params[:page])

    when_group = params[:when_group]
    if when_group
      @meals = @meals.where("starting_date = ?", when_group).order("created_at DESC")
    end

    price_group = params[:price_group]
    if price_group
      @meals = @meals.where("price_cents <= ?", price_group).order("created_at DESC")
    end
    if params[:start] && params[:end]
      start_time = params[:start]["{:prefix=>:start_date}(4i)"] +":"+ params[:start]["{:prefix=>:start_date}(5i)"]+":00"
      end_time = params[:end]["{:prefix=>:end_date}(4i)"] +":"+ params[:end]["{:prefix=>:end_date}(5i)"]+":00"
      if start_time || end_time
          @meals_noon = @meals.where('take_away_noon_starts_at < ? AND take_away_noon_ends_at > ?', start_time, end_time)
        if @meals_noon.count == 0
          @meals = @meals.where('take_away_evening_starts_at < ? AND take_away_evening_ends_at > ?', start_time, end_time)
        else
          @meals = @meals_noon
        end
      end
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

    @meal = @restaurant.meals.update(params_meal)
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
    @meal.active = true
    @meal.stock = @meal.quantity
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
