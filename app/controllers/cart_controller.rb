class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :current_order

  def show
  end

  private

  def current_order
    @order ||= current_user.orders.where(status: "cart").first_or_create
  end
end
