class MonetizeMeal < ActiveRecord::Migration
  def change
    add_monetize :meals, :price, currency: { present: false }
  end
end
