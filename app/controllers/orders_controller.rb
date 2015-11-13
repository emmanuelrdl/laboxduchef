
class OrdersController < ApplicationController
  def show
    @order = current_user.orders.where(status: "paid").find(params[:id])

  class OrdersController < ApplicationController

  def create



  end
end
