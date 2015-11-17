class UsersController < ApplicationController
  before_action :set_user

  def show
    @restaurants = current_user.restaurants
    @paid_orders = Order.where(status: 'paid')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
