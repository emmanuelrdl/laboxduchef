class DeleteColumnFromRestaurant < ActiveRecord::Migration
  def change
    remove_column :meals, :sku, :string
    remove_column :orders, :meal_sku, :string
    add_column :restaurants, :iban, :string
  end
end
