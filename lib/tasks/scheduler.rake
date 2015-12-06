

namespace :scheduler do

    task :update_meal_active => :environment do

        @all_meals = Meal.all
        @meals = @all_meals.where("active = ?", true)
        @meals.each do |meal|
          if
            meal.starting_date < Date.today + 2
            meal.active = false
          else
            meal.active = true
          end
          meal.save
        end


    end


    task :send_notification => :environment do
        @all_meals = Meal.all
        @meals = @all_meals.where("active = ?", true)
        @all_users = User.all
        @users = @all_users.where("notification = ?", true)
        @meals.each do |meal|
          @users.each do |user|
            if
              user.postal_code == meal.restaurant.postal_code
              @deliver_notification == true
              meal_to_send = meal
              @meals_to_send = []
              @meals_to_send << meal_to_send
            end
          end
        end
        if @deliver_notification == true
        meal = @meals_to_send.first
        UserMailer.notification_mail(self, meal).deliver_now
        end
    end



end
