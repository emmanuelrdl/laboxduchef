class AddPayementToOrder < ActiveRecord::Migration
  def change
      add_column :orders, :payment, :json
  end
end
