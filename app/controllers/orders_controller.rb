
class OrdersController < ApplicationController
  def show
    @order = current_user.orders.where(status: "paid").find(params[:id])
    @order_meal = OrderMeal.find(params[:meal_id][:order_id])

    end

  def update

    @order = current_user.orders.where(status: "cart").find(params[:id])
    @order_meal = OrderMeal.find(params[:meal_id][:order_id])
    order = Order.update!(meal_sku: @meal.sku, amount: @order.amount, status: 'cart')

    redirect_to new_order_payment_path(order)

  end


  private


  def params_order_meal
      params.require(:order_meal).permit(:meal_id, :quantity)
  end







end



