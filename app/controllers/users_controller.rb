class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]

  def show
    @last_order = current_user.orders.where(status: 'paid').last
    @restaurants = current_user.restaurants
    @paid_orders = current_user.orders.where(status: "paid")


    @restaurants.first.meals.each do |meal|
    @meal = meal


    @meal.order_meals.each do |order_meal|
    @order_direction = order_meal.order.id
      end
        end







  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
