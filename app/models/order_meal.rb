class OrderMeal < ActiveRecord::Base
  belongs_to :order
  belongs_to :meal
  monetize :price_cents


  after_save :update_order


  private

  def update_order
    if order.order_meals.count = 1
       order.amount = price
    else
       order.amount += price
    end
  end

end
