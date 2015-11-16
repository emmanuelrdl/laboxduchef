class RemovePriceToOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :total_price, :float
  end
end
