class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order

  def new
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
    @initial_stock = @order.order_meals.first.meal.stock
    # @new_stock = @initial_stock - @order.order_meals.first.quantity
    # @order.order_meals.first.meal.stock = @new_stock
    @order_meals = @order.order_meals
    @order_meals.each do |order_meal|
      order_meal.meal.stock -= order_meal.quantity
      order_meal.meal.save
    end



    rescue Stripe::CardError => e

    flash[:error] = e.message

    @order = current_user.orders.where(status: "paid")
    redirect_to orders_path
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
end
