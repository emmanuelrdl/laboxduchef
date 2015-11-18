class AddSeatedPriceToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :seated_price, :integer
  end
end
