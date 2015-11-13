class OrderMealsController < ApplicationController
  # before_action :set_order_meal, only: [:show, :edit, :update, :destroy]

  # def index

  # end

  # def new

  # end

  def create
    @meal = Meal.find(params[:order_meal][:meal_id])
    @order_meal = OrderMeal.new(params_order_meal)
    @order_meal.price = @meal.price * @order_meal.quantity
    @order_meal.order = current_order
    @order_meal.save
    redirect_to cart_path
  end



  # def edit

  # end

  # def update

  # end

  def destroy
    @meal.delete
    redirect_to meal_path
  end


  private

  # def set_order_meal
  #   @order_meal = Order_meal.find(params[:id])
  # end

  def current_order
    @order ||= current_user.orders.where(status: "cart").first_or_create
  end

  def params_order_meal
    params.require(:order_meal).permit(:meal_id, :quantity)
  end


end
