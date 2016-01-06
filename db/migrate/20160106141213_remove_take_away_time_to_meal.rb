class RemoveTakeAwayTimeToMeal < ActiveRecord::Migration
  def change
    remove_column :meals, :take_away_noon_starts_at, :time
    remove_column :meals, :take_away_noon_ends_at, :time
    remove_column :meals, :take_away_evening_starts_at, :time
    remove_column :meals, :take_away_evening_ends_at, :time
  end
end
