class AddOpeningTimeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :open_noon, :boolean
    add_column :restaurants, :open_evening, :boolean
  end
end
