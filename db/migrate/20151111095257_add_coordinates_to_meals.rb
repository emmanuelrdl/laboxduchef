class AddCoordinatesToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :latitude, :float
    add_column :meals, :longitude, :float
  end
end
