
class OrdersController < ApplicationController
  def show
    @order = current_user.orders.where(status: "paid").find(params[:id])


    @order_meal = OrderMeal.find(params[:meal_id][:order_id])

    end

  def create



  end


  private


  def params_order_meal
      params.require(:order_meal).permit(:meal_id, :quantity)
  end







end



