class OrderMeal < ActiveRecord::Base
  belongs_to :order
  belongs_to :meal
  monetize :price_cents


  # after_save :update_order


  private

  # def update_order
  #   @order = current_user.orders.where(status: "cart").first_or_create
  #     if @order.order_meals.count = 1
  #        @order.amount = price
  #        raise

  #     else
  #        @order.amount += price
  #     end
  # end

end
