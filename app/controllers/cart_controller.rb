  class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :current_order

  def show
    @order_meals = current_order.order_meals
    @total_price = @order.amount
  end

  def destroy
    current_order.order_meals.destroy_all
    current_order.update(amount: 0)
    redirect_to cart_path
  end

  private

  def current_order
    @order ||= current_user.orders.where(status: "cart").first_or_create
  end
end
