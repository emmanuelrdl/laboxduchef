class ChangeRestaurantPostalCode < ActiveRecord::Migration
  def change
    change_column :restaurants, :postal_code, :integer
  end
end
