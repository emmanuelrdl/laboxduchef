
class Api::V1::PaymentsController < Api::V1::BaseController

    
  def new
    @order = current_user.orders.where(status:"cart").last
    @meal = Meal.find(@order.meal_id)
  end

  def create
    @amount = "10"
    customer = Stripe::Customer.create(
      source: params[:stripeSource],
      email: current_user.email
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount:       "100",  # in cents
      description:  "Payement d'une portion ",
      currency:     'eur'
    )
    @order = current_user.orders.last
    @order.update(payment: charge.to_json, status: 'confirmed')
      
  end







end

