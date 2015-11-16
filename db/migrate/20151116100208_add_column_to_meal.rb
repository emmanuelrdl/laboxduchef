class AddColumnToMeal < ActiveRecord::Migration
  def change
     add_column :meals, :sku, :string
  end
end
