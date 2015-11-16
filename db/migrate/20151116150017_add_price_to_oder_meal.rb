class AddPriceToOderMeal < ActiveRecord::Migration
  def change
     add_monetize :order_meals, :price, currency: { present: false }
  end
end
