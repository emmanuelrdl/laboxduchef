class AddStockToMeal < ActiveRecord::Migration
  def change
     add_column :meals, :stock, :integer
  end
end
