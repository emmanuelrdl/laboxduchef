class Api::V1::OrdersController < Api::V1::BaseController
	acts_as_token_authentication_handler_for User, except: [ :index, :show ]

  
  
	def create
    @meal = Meal.find(params_order[:meal_id])
    if params[:order][:quantity].to_i <= @meal.stock && @meal.active && params[:order][:quantity].to_i >= 1
      @order = current_user.orders.where(status: "cart").create
      @order.update(meal_id: @meal.id)
      @order.quantity = params_order[:quantity].to_i
      @order.amount_cents = @meal.price_cents * @order.quantity
      @order.save
      @order.meal.stock -= @order.quantity
        if @order.meal.stock <= 0
           @order.meal.active = false
        else
           @order.meal.active = true
        end
      @order.meal.save
      redirect_to new_cart_payment_path
    else params[:order][:quantity].to_i <= @meal.stock
      flash[:alert] = "Quantité insuffisante"
      redirect_to meal_path(@meal)
    end
  end

  


private

def params_order
      params.require(:order).permit(:meal_id, :quantity, :user_id, :amount, :status)
  end
  
end
