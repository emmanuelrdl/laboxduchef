class OrderMealsController < ApplicationController
  before_action :set_order_meal, only: [:show, :edit, :update, :destroy]

  def index

  end

  def new

  end

  def create
    @meal = Meal.find(params[:meal_id])
    @order_meal = Oder_meal.new(params_order_meal)
    @order_meal.price = @meal.price * @meal.quantity

    @order.save
  end

  def edit

  end

  def update

  end

  def destroy

  end


  private

  def set_order_meal
    @order_meal = Order_meal.find(params[:id])
  end

  def params_order_meal
    params.require(:order_meal).permit(:order_id, :meal_id, :price, :quanity)
  end


end
