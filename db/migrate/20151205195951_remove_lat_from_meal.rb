class RemoveLatFromMeal < ActiveRecord::Migration
  def change
    remove_column :meals, :latitude, :float
    remove_column :meals, :longitude, :float
    remove_column :restaurants, :category, :string
  end
end
