class RenameRestaurantZipCode < ActiveRecord::Migration
  def change
    rename_column :restaurants, :zip_code, :postal_code
    rename_column :restaurants, :city, :locality
  end
end
