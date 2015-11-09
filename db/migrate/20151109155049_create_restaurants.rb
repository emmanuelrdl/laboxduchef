class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :category
      t.string :address
      t.string :city
      t.integer :zip_code
      t.string :picture
      t.string :phone_number
      t.string :iban
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
