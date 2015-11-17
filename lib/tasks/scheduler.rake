task :update_meal_active => :environment do
  Meal.update_active
end
