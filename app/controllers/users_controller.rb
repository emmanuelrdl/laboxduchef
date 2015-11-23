class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]

  def show

    @last_order = current_user.orders.where(status: 'confirmed').last
    @restaurants = current_user.restaurants
    @paid_orders = current_user.orders.where(status: "confirmed")



    if current_user.restaurant_owner
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals
    elsif current_user.orders.count >= 1
    @last_order = current_user.orders.where(status: 'confirmed').last
    @restaurants = current_user.restaurants
    @paid_orders = current_user.orders.where(status: "confirmed")

    end



  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
