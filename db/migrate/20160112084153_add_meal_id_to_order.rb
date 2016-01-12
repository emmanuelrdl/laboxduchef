class AddMealIdToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :meal, index: true, foreign_key: true
  end
end
