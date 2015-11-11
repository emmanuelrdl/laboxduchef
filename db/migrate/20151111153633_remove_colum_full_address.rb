class RemoveColumFullAddress < ActiveRecord::Migration
  def change
    remove_column :restaurants, :full_address, :string
  end
end
