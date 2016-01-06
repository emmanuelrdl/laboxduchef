class AddTakeAwayTimeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :take_away_noon_starts_at, :time
    add_column :restaurants, :take_away_noon_ends_at, :time
    add_column :restaurants, :take_away_evening_starts_at, :time
    add_column :restaurants, :take_away_evening_ends_at, :time
  end
end
