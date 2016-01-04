class OrderMealsController < ApplicationController
  # before_action :set_order_meal, only: [:show, :edit, :update, :destroy]

  # def index



  # def new

  # end

  def create
    @meal = Meal.find(params_order_meal[:meal_id])

    @order_meal = current_order.order_meals.where(meal_id: @meal.id).first_or_initialize

    if @order_meal.quantity
      @order_meal.quantity += params_order_meal[:quantity].to_i
    else
      @order_meal.quantity = params_order_meal[:quantity].to_i
    end

    @order_meal.price = @meal.price * @order_meal.quantity
    @order_meal.save

    @order.amount_cents = @order.order_meals.sum('price_cents')
    @order.save

    redirect_to new_cart_payment_path
  end



  # def edit

  # end

  # def update

  # end

  def destroy
    @meal.delete
    redirect_to meal_path
  end


  private

  # def set_order_meal
  #   @order_meal = Order_meal.find(params[:id])
  # end

  def current_order
    @order ||= current_user.orders.where(status: "cart").first_or_create
  end

  def params_order_meal
    params.require(:order_meal).permit(:meal_id, :quantity)
  end


end
