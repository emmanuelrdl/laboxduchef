class AddStateToRestaurant < ActiveRecord::Migration
  def change
     add_column :restaurants, :confirmed, :boolean
  end
end
