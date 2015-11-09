class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :picture
      t.string :name
      t.float :price
      t.integer :quantity
      t.text :description
      t.references :restaurant, index: true, foreign_key: true
      t.date :strating_date
      t.time :take_away_noon_starts_at
      t.time :take_away_evening_starts_at
      t.time :take_away_noon_ends_at
      t.time :take_away_evening_ends_at

      t.timestamps null: false
    end
  end
end
