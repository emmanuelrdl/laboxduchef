class AddColumnToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :street_number, :string
    add_column :restaurants, :route, :string
  end
end
