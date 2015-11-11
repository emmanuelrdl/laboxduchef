class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    @meals = Meal.all

    @markers = Gmaps4rails.build_markers(@cats) do |meal, marker|
    marker.lat meal.latitude
    marker.lng meal.longitude
    end

    if params[:city].present?
      @meals = Meal.search_by_city(params[:city]).order("created_at DESC").page(params[:page])
    else
      @meals = Meal.all.order('created_at DESC').page(params[:page])
    end
  end

  def show
    @alert_message = "You are viewing #{@meal.name}"
    @meal_coordinates = [{ lat: @meal.latitude, lng: @meal.longitude }]
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(params_meal)
    if @meal.save
      redirect_to meals_path(@meal)
    else
       render :new
     end
  end

  def edit
  end

  def update
    @meal.update(params_meal)
    if @meal.save
    redirect_to meal_path(@meal)
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

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def params_meal
    params.require(:meal).permit(:name, :description, :price, :quantity, :picture, :starting_date, :take_away_noon_starts_at, :take_away_evening_starts_at, :take_away_noon_ends_at, :take_away_evening_ends_at)
  end

end
