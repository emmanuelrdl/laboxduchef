class AddCgvToUser < ActiveRecord::Migration
  def change
      add_column :users, :cgv, :boolean
  end
end
