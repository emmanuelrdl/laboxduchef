class AddPermanentOfferToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :permanent, :boolean
  end
end
