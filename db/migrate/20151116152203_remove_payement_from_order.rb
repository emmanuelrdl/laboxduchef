class RemovePayementFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :payement, :json
  end
end
