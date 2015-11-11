class AddFullAddressToRestaurant < ActiveRecord::Migration
  def change
     add_column :restaurants, :full_address, :string
  end
end
