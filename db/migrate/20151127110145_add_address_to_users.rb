class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street, :string
    add_column :users, :postal_code, :integer
    add_column :users, :locality, :string
    remove_column :users, :address, :string
  end
end
