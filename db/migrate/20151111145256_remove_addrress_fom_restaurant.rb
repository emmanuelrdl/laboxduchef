class RemoveAddrressFomRestaurant < ActiveRecord::Migration
  def change
    remove_column :restaurants, :address, :string
  end
end
