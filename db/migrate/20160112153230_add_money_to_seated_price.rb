class AddMoneyToSeatedPrice < ActiveRecord::Migration
  def change
    add_monetize :meals, :seated_price,  currency: { present: false }
  end
end
