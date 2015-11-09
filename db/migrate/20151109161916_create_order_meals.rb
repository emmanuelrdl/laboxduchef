class CreateOrderMeals < ActiveRecord::Migration
  def change
    create_table :order_meals do |t|
      t.references :order, index: true, foreign_key: true
      t.references :meal, index: true, foreign_key: true
      t.float :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
