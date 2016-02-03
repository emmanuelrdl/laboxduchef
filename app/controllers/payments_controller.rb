require 'restclient'

class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order , only: [:new, :create]
  before_action :navbar_choice


  def new
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
    send_order_confirmation
    blowerio = RestClient::Resource.new(ENV['BLOWERIO_URL'])
    blowerio['/messages'].post :to => '+33663436165', :message => 'LA BOX DES CHEFS - '
    redirect_to cart_payment_path(@order)
    rescue Stripe::CardError => e
    flash[:error] = e.message
  end



  def show
    @order = current_user.orders.where(status: "confirmed").last
    @amount = @order.amount
    @restaurant_coordinates = [{ lat: @order.meal.restaurant.latitude, lng: @order.meal.restaurant.longitude }]
    @restaurant_full_address = @order.meal.restaurant.full_address
  end


  def send_order_confirmation
      amount = Order.last.amount
      meal = Order.last.meal
      quantity = Order.last.quantity
      name = Order.last.meal.name
      restaurant = meal.restaurant
      user = current_user
      UserMailer.order_confirmation(user, amount, name, restaurant, quantity).deliver_now
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


  def navbar_choice
    @navbar_other = true
  end

end
