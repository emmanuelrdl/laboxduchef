class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order , only: [:new, :create]
  before_action :navbar_choice
  # before_action :set_order_meal, only: [:new]

  def new
    # @order = current_user.orders.where(status: "cart")
    @order = current_user.orders.where(status: "cart").first

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
      description:  "Payement d'une portion ",
      currency:     'eur'
    )


    @order.update(payment: charge.to_json, status: 'confirmed')
    @order = current_user.orders.where(status: "confirmed")
    redirect_to cart_payment_path(@order)

    rescue Stripe::CardError => e

    flash[:error] = e.message

  end



  def show
    @order = current_user.orders.where(status: "confirmed").last
    @amount = @order.amount
  end

  def navbar_choice
    @navbar_other = true
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
