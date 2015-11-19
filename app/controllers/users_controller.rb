class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]

  def show

    @last_order = current_user.orders.where(status: 'paid').last
    @restaurants = current_user.restaurants
    @paid_orders = current_user.orders.where(status: "paid")



    if current_user.restaurant_owner?
      @restaurants = current_user.restaurants
      @restaurants.first.meals.each do |meal|
        @meal = meal
        @meal.order_meals.each do |order_meal|
          @order_direction = order_meal.order.id
        end
      end

    else
    @order = Order.find(params[:id])
    @last_order = current_user.orders.where(status: 'paid').last
    @restaurants = current_user.restaurants
    @paid_orders = current_user.orders.where(status: "paid")
    end



  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
