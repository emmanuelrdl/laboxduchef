class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]

  def show
    @last_order = current_user.orders.last
    @restaurants = current_user.restaurants
    @paid_orders = Order.where(status: 'paid')

    @meal = Meal.find(params[:id])
    @restaurant_coordinates = [{ lat: @last_order.order_meals.first.meal.restaurant.latitude, lng: @last_order.order_meals.first.meal.restaurant.longitude }]
  end


  private

  def set_user
    @user = User.find(params[:id])
  end
end
