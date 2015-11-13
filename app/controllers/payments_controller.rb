class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order

  def new
    @total_price = current_order.order_meals.sum(:price)
  end

  def create
    # FUTURE: stripe charge creation here

    current_order.status = "paid"

    if current_order.save
      flash[:notice] = "Commande effectuée avec succès."
      redirect_to order_path(current_order)
    else
      flash[:alert] = "Nous ne parvenons pas à effectuer le paiement."
      redirect_to new_cart_payment_path
    end
  end

  private

  def check_order
    unless current_order
      flash[:alert] = "Commande non trouvée"
      redirect_to cart_path
    end
  end

  def current_order
    @order ||= current_user.orders.where(status: "cart").first
  end
end
