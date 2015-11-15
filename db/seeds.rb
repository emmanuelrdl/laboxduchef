# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Meal.destroy_all
Restaurant.destroy_all
User.destroy_all


proprio_les_saltimbanques= User.create!(
  first_name: "Melanie",
  last_name: "Laurent",
  phone_number: "0145506070",
  restaurant_owner: true,
  email: "boss@saltim.com",
  password: "12345678",
  password_confirmation: "12345678"
)

les_saltimbanques = proprio_les_saltimbanques.restaurants.create!(
  name: "Les Saltimbanques",
  category: "Cuisine Francaise",
  street: "17 Villa Gaudelet",
  locality: "Paris",
  postal_code: 75011,
  phone_number: "0145506070",
  iban: "867676756757",
  picture: File.open(Rails.root.join("db/seeds/pictures/saltimbanques.jpg")),
  confirmed: true

)

coque_au_vin = les_saltimbanques.meals.create!(
  price: 5.50,
  name: "Coq au vin",
  quantity: 12,
  description: "Coque cuisiné au vin rouge avec riz en accompagnement",
  picture: File.open(Rails.root.join("db/seeds/pictures/coq.jpeg")),
  starting_date: Date.current,
  take_away_noon_starts_at: Date.current.noon,
  take_away_noon_ends_at: Date.current.noon + 1.hour,
  take_away_evening_starts_at: Date.current.noon + 8.hour,
  take_away_evening_ends_at: Date.current.noon + 10.hour,
  active: false

)

proprio_le_blue_valentine = User.create!(
  first_name: "Marie",
  last_name: "Gaudelet",
  phone_number: "0145678989",
  restaurant_owner: true,
  email: "boss@valentine.com",
  password: "12345678",
  password_confirmation: "12345678"
)

le_blue_valentine = proprio_le_blue_valentine.restaurants.create!(
  name: "Le Blue Valentine",
  category: "Cuisine Francaise",
  street: "13 Rue de la Pierre Levée",
  locality: "Paris",
  postal_code: 75011,
  phone_number: "0145678989",
  iban: "99797878678",
  picture: File.open(Rails.root.join("db/seeds/pictures/blue.jpg")),
  confirmed: true

)

boeuf_bourguignon = le_blue_valentine.meals.create!(
  price: 5.50,
  name: "Boeuf Bourguignon",
  quantity: 12,
  description: "Viande de boeuf mijoté au vin et aux légumes",
  picture: File.open(Rails.root.join("db/seeds/pictures/bourguignon.jpg")),
  starting_date: Date.current,
  take_away_noon_starts_at: Date.current.noon,
  take_away_noon_ends_at: Date.current.noon + 1.hour,
  take_away_evening_starts_at: Date.current.noon + 8.hour,
  take_away_evening_ends_at: Date.current.noon + 10.hour,
  active: true
)

proprio_astier = User.create!(
  first_name: "Jean",
  last_name: "Marignant",
  phone_number: "0145789056",
  restaurant_owner: true,
  email: "boss@astier.com",
  password: "12345678",
  password_confirmation: "12345678"
)

astier = proprio_astier.restaurants.create!(
  name: "Astier",
  category: "Cuisine Francaise",
  street: "44 rue Jean Pierre Timbaud",
  locality: "Paris",
  postal_code: 75011,
  phone_number: "0145789056",
  iban: "97878679678676",
  picture: File.open(Rails.root.join("db/seeds/pictures/astier.jpg")),
  confirmed: true

)

poulet_basquaise = astier.meals.create!(
  price: 5.50,
  name: "Poulet Basquaise",
  quantity: 12,
  description: "Poulet poivrons rouges et sauce piquante accompagné de riz",
  picture: File.open(Rails.root.join("db/seeds/pictures/basquaise.jpg")),
  starting_date: Date.current,
  take_away_noon_starts_at: Date.current.noon,
  take_away_noon_ends_at: Date.current.noon + 1.hour,
  take_away_evening_starts_at: Date.current.noon + 8.hour,
  take_away_evening_ends_at: Date.current.noon + 10.hour,
  active: true
)






