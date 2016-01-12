class ChangeSeatedPriceFormat < ActiveRecord::Migration
  def change
     change_column :meals, :seated_price, :decimal, :precision => 8, :scale => 2
  end
end
