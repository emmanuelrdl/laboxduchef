class AddStartingDateToMeal < ActiveRecord::Migration
  def change
     add_column :meals, :second_date, :date
  end
end
