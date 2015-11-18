class RemoveIbanFromRestaurant < ActiveRecord::Migration
  def change
     remove_column :restaurants, :iban, :string
  end
end
