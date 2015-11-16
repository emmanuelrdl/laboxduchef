class AddStateToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :active, :boolean
  end
end
