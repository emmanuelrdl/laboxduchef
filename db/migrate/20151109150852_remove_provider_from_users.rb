class RemoveProviderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :picture, :string
    remove_column :users, :token_expiry, :datetime
    remove_column :users, :token, :string
  end
end


