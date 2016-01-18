  class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :current_order
  before_action :navbar_choice

  def show
    @order_meals = current_order.order_meals
    @total_price = @order.amount
  end

  def destroy
    current_order.update(amount: 0, status:"cancelled")
    flash[:notice] = "Votre panier a bien été vidé"
    redirect_to root_path
  end

  private

  def current_order
    @order ||= current_user.orders.where(status: "cart").first_or_create
  end

  def navbar_choice
    @navbar_other = true
  end

end
