class OrdersController < ApplicationController
  before_action :navbar_choice


    def create
      @meal = Meal.find(params_order[:meal_id])
      if params[:order][:quantity].to_i <= @meal.stock
        @order = current_user.orders.where(status: "cart").first_or_create
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
      else
        flash[:alert] = "Stock insuffisant"
        redirect_to meal_path(@meal)
      end
    end

  def show
    @order = Order.where(status: "confirmed").find(params[:id])
    @restaurants = current_user.restaurants
      @restaurants.first.meals.each do |meal|
      @meal = meal

      end
  end

  def index
     if current_user.restaurant_owner
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals.page(params[:page])
      end
  end




  def update
    @order = current_user.orders.where(status: "cart").find(params[:id])
    order = Order.update!(amount: @order.amount, status: 'cart')
    redirect_to new_order_payment_path(order)
  end

  def navbar_choice
    @navbar_other = true
  end

  private


  def params_order
      params.require(:order).permit(:meal_id, :quantity)
  end

  def current_order
    @order ||= current_user.orders.where(status: "cart").first_or_create
  end





end



