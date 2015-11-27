class AddNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification, :boolean
    add_column :users, :address, :string
  end
end
