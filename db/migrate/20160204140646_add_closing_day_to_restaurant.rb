class AddClosingDayToRestaurant < ActiveRecord::Migration
  def change
     add_column :restaurants, :closing_day_one, :string
     add_column :restaurants, :closing_day_two, :string
  end
end
