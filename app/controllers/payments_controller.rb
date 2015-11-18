class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order
  # before_action :set_order_meal, only: [:new]

  def new
    # @order = current_user.orders.where(status: "cart")
    @order_meals = @order.order_meals

    @amount = @order.amount
  end


  def create
    @amount = @order.amount_cents
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email: params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount:       @amount,  # in cents
      description:  "Payment for teddy  for order ",
      currency:     'eur'
    )

    @current_user ||= order.orders.where(status: "cart").first_or_create
    @order.update(payment: charge.to_json, status: 'paid')


    @order_meals = @order.order_meals
    @order_meals.each do |order_meal|
    order_meal.meal.stock -= order_meal.quantity
      if order_meal.meal.stock <= 0
         order_meal.meal.active = false
      else
         order_meal.meal.active = true
      end
      order_meal.meal.save
    end

    @order = current_user.orders.where(status: "paid")
    redirect_to cart_payment_path(@order)

    rescue Stripe::CardError => e

    flash[:error] = e.message

  end



  def show
    @order = current_user.orders.where(status: "paid").last
    @order_meals = @order.order_meals

    @amount = @order.amount
  end

  private

  def check_order
    unless current_order
      flash[:alert] = "Commande non trouvée"
      redirect_to cart_path
    end
  end

  def current_order
    @order = current_user.orders.where(status: "cart").first_or_create
  end

  # def set_order_meal
  #   @restaurant = OrderMeal.find(params[:meal_id][:quantity])
  # end

  def params_order_meal
    params.require(:order_meal).permit(:meal_id, :quantity, :order_id)
  end

end
