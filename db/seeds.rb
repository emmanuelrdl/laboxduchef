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




emmanuel = User.create!(
  first_name: "Emmanuel",
  last_name: "Rudelle",
  phone_number: "0145506070",
  restaurant_owner: false,
  email: "eml.rudelle@gmail.com",
  password: "password",
  password_confirmation: "password",
  notification: false,
  cgv: true

)



proprio_les_saltimbanques= User.create!(
  first_name: "Melanie",
  last_name: "Laurent",
  phone_number: "0663436165",
  restaurant_owner: true,
  email: "boss@saltim.com",
  password: "12345678",
  password_confirmation: "12345678",
  notification: false,
  cgv: true




)

les_saltimbanques = proprio_les_saltimbanques.restaurants.create!(
  name: "Les Saltimbanques",
  street: "17 Villa Gaudelet",
  locality: "Paris",
  postal_code: 75011,
  phone_number: "0145506070",
  picture: File.open(Rails.root.join("db/seeds/pictures/saltimbanques.jpg")),
  confirmed: true,
  iban: "12345678",
  take_away_noon_starts_at: Date.current.noon,
  take_away_noon_ends_at: Date.current.noon + 1.hour,
  take_away_evening_starts_at: Date.current.noon + 8.hour,
  take_away_evening_ends_at: Date.current.noon + 10.hour,
  open_evening: true,
  open_noon: false


)

coq_au_vin = les_saltimbanques.meals.create!(
  price: 5,
  name: "Coq au vin",
  quantity: 12,
  description: "Coq cuisiné au vin rouge avec riz en accompagnement",
  picture: File.open(Rails.root.join("db/seeds/pictures/coq.jpeg")),
  starting_date: Date.today,
  second_date: Date.today + 1,
  active: true,
  stock: 6,
  seated_price: 16,
  take_away_noon: true,
  take_away_evening: false

)

hachis = les_saltimbanques.meals.create!(
  price: 5.5,
  name: "Hachis Parmentier",
  quantity: 7,
  description: "Bonne viande de boeuf et pommes de terre du jardin",
  picture: File.open(Rails.root.join("db/seeds/pictures/hachis-parmentier.jpg")),
  starting_date: Date.current,
  second_date: Date.today + 1,
  active: true,
  stock: 9,
  seated_price: 12,
  take_away_noon: true,
  take_away_evening: true

)


proprio_le_blue_valentine = User.create!(
  first_name: "Marie",
  last_name: "Gaudelet",
  phone_number: "0145678989",
  restaurant_owner: true,
  email: "boss@valentine.com",
  password: "12345678",
  password_confirmation: "12345678",
  notification: false,
  cgv: true
)

le_blue_valentine = proprio_le_blue_valentine.restaurants.create!(
  name: "Le Blue Valentine",
  street: "13 Rue de la Pierre Levée",
  locality: "Paris",
  postal_code: 75011,
  phone_number: "0145678989",
  picture: File.open(Rails.root.join("db/seeds/pictures/blue.jpg")),
  confirmed: true,
  iban: "12345678",
  take_away_noon_starts_at: Date.current.noon,
  take_away_noon_ends_at: Date.current.noon + 1.hour,
  take_away_evening_starts_at: Date.current.noon + 8.hour,
  take_away_evening_ends_at: Date.current.noon + 10.hour,
  open_evening: false,
  open_noon: true

)

boeuf_bourguignon = le_blue_valentine.meals.create!(
  price: 7,
  name: "Boeuf Bourguignon",
  quantity: 12,
  description: "Viande de boeuf mijotée au vin et aux légumes",
  picture: File.open(Rails.root.join("db/seeds/pictures/bourguignon.jpg")),
  starting_date: Date.current,
  second_date: Date.today + 1,
  active: true,
  stock: 12,
  seated_price: 14,
  take_away_noon: true,
  take_away_evening: true
)


choucroute = le_blue_valentine.meals.create!(
  price: 5,
  name: "Choucroute ",
  quantity: 6,
  description: "Belle choucroute garnie et savoureuse",
  picture: File.open(Rails.root.join("db/seeds/pictures/choucroute.jpg")),
  starting_date: Date.current,
  second_date: Date.today + 1,
  active: true,
  stock: 12,
  seated_price: 16,
  take_away_noon: true,
  take_away_evening: true
)

tomates = le_blue_valentine.meals.create!(
  price: 5.5,
  name: "Tomates farcies",
  quantity: 8,
  description: "Belles tomates farcies accompagnées de riz basmati",
  picture: File.open(Rails.root.join("db/seeds/pictures/tomates.jpg")),
  starting_date: Date.current,
  second_date: Date.today + 1,
  active: true,
  stock: 12,
  seated_price: 17.5,
  take_away_noon: true,
  take_away_evening: true
)




proprio_astier = User.create!(
  first_name: "Jean",
  last_name: "Marignant",
  phone_number: "0145789056",
  restaurant_owner: true,
  email: "boss@astier.com",
  password: "12345678",
  password_confirmation: "12345678",
  cgv: true

)

astier = proprio_astier.restaurants.create!(
  name: "Astier",
  street: "44 rue Jean Pierre Timbaud",
  locality: "Paris",
  postal_code: 75011,
  phone_number: "0145789056",
  picture: File.open(Rails.root.join("db/seeds/pictures/astier.jpg")),
  confirmed: true,
  iban: "12345678",
  take_away_noon_starts_at: Date.current.noon,
  take_away_noon_ends_at: Date.current.noon + 1.hour,
  take_away_evening_starts_at: Date.current.noon + 8.hour,
  take_away_evening_ends_at: Date.current.noon + 10.hour,
  open_evening: true,
  open_noon: true

)

poulet_basquaise = astier.meals.create!(
  price: 5.50,
  name: "Poulet Basquaise",
  quantity: 5,
  description: "Poulet poivrons rouges et sauce piquante accompagné de riz",
  picture: File.open(Rails.root.join("db/seeds/pictures/basquaise.jpg")),
  starting_date: Date.current,
  second_date: Date.today + 1,
  active: true,
  stock: 12,
  seated_price: 13.5,
  take_away_noon: true,
  take_away_evening: true
)






gratin = astier.meals.create!(
  price: 4.50,
  name: "Gratin dauphinois",
  quantity: 12,
  description: "Pomme de terre au four et crème fraiche",
  picture: File.open(Rails.root.join("db/seeds/pictures/gratin.jpeg")),
  starting_date: Date.current,
  second_date: Date.today + 1,
  active: true,
  stock: 12,
  seated_price: 12,
  take_away_noon: true,
  take_away_evening: true
)





