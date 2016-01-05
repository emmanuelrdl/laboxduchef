class AddTakeAwayNoonToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :take_away_noon, :boolean
    add_column :meals, :take_away_evening, :boolean
  end
end
