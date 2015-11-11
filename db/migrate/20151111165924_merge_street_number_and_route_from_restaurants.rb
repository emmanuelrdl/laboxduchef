class MergeStreetNumberAndRouteFromRestaurants < ActiveRecord::Migration
  def change
    rename_column :restaurants, :street_number, :street
    remove_column :restaurants, :route, :string
  end
end
