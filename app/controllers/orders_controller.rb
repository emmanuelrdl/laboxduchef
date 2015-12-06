class OrdersController < ApplicationController

  def show
    @order = Order.where(status: "confirmed").find(params[:id])
    @order_meals = @order.order_meals
    @restaurants = current_user.restaurants
      @restaurants.first.meals.each do |meal|
      @meal = meal

      end
  end

  def index
     if current_user.restaurant_owner
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals.page(params[:page])
      end
  end


  def update
    @order = current_user.orders.where(status: "cart").find(params[:id])
    @order_meal = OrderMeal.find(params[:meal_id][:order_id])
    order = Order.update!(amount: @order.amount, status: 'cart')
    redirect_to new_order_payment_path(order)
  end


  private


  def params_order_meal
      params.require(:order_meal).permit(:meal_id, :quantity)
  end







end



