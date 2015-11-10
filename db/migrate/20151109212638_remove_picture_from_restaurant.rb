class RemovePictureFromRestaurant < ActiveRecord::Migration
  def change
    remove_column :restaurants, :picture, :string
  end
end
