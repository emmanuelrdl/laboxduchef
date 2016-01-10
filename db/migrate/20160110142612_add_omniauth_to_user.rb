class AddOmniauthToUser < ActiveRecord::Migration
  def change
     add_column :users, :token_expiry, :datetime
     add_column :users, :token, :string
     add_column :users, :uid, :string
     add_column :users, :provider, :string
  end
end
