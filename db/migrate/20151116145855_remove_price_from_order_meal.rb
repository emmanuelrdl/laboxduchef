class RemovePriceFromOrderMeal < ActiveRecord::Migration
  def change
    remove_column :order_meals, :price, :integer
  end
end
