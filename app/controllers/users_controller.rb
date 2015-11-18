class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]

  def show
    @last_order = current_user.orders.where(status: 'paid').last
    @restaurants = current_user.restaurants
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
