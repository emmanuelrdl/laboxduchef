class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_meals, only: [:show, :edit, :update, :destroy]

  def index
    @meals = Meal.all.page(params[:page])
  end

  def show
    "You are viewing #{@meal.name}"
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(params_meals)

    if @meal.save
      redirect_to meals_path(@meal)
    else
       render :new
     end
  end

  def edit
    @meal.save
  end

  def update
    if @meal.update(params_meals)
      redirect_to meals_path(@meal)
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

  def set_meals
    @meal = Meal.find(params[:id])
  end

  def params_meals
    params.require(:meal).permit(:name, :description, :price, :quantity, :picture, :starting_date, :take_away_noon_starts_at, :take_away_evening_starts_at, :take_away_noon_ends_at, :take_away_evening_ends_at)
  end

end
