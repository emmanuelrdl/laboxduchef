  class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :current_order
  before_action :navbar_choice


  def destroy
    current_order.update(amount: 0, status:"cancelled")
    @current_stock = current_order.meal.stock + current_order.quantity
    @meal = current_order.meal
    @meal.update(stock:@current_stock, active:true)
    flash[:notice] = "Votre panier a bien été vidé"
    redirect_to root_path
  end

  private

  def current_order
    @order ||= current_user.orders.where("status = ?", "cart").first_or_create
  end

  def navbar_choice
    @navbar_other = true
  end

end
