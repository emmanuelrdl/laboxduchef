class ChangeMealPrice < ActiveRecord::Migration
  def change
    remove_column :meals, :price
  end
end
