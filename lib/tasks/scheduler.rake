task :update_meal_active => :environment do

    @all_meals = Meal.all
    @meals = @all_meals.where("active = ?", true)
    @meals.each do |meal|
      if
        meal.starting_date < Date.today + 1
        meal.active = false
      else
        meal.active = true
      end
      meal.save
    end


end
