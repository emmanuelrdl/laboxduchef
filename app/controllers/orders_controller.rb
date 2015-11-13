  class OrdersController < ApplicationController

  def create


  end

  private

  def params_orders
    params.require(:order).permit(:)
  end

end
