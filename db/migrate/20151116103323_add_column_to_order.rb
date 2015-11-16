class AddColumnToOrder < ActiveRecord::Migration
  def change
    add_monetize :orders, :amount, currency: { present: false }
    add_column :orders, :meal_sku, :string
    add_column :orders, :payement, :json
  end
end
