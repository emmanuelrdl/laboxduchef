class RenameColumnStratingDateInTableMealsToStartingDate < ActiveRecord::Migration
  def change
    rename_column :meals, :strating_date, :starting_date
  end
end
