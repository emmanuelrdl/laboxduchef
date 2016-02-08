
namespace :scheduler do

    task :update_meal_active => :environment do

        @meals = Meal.all
        @meals.each do |meal|
              if meal.second_date?
                if
                  meal.second_date < Date.today
                  meal.active = false
                else
                  meal.active = true
                end
              elsif meal.starting_date?
                if
                  meal.starting_date < Date.today
                  meal.active = false
                else
                  meal.active = true
                end
               elsif meal.permanent? && meal.stock >= 0
                if meal.restaurant.closing_day_one? && meal.restaurant.closing_day_two?
                  if meal.restaurant.closing_day_one == Date.today.strftime("%A") || meal.restaurant.closing_day_two == Date.today.strftime("%A")
                  meal.active = false
                  else
                  meal.active = true
                  end
                elsif meal.restaurant.closing_day_one?
                  if meal.restaurant.closing_day_one == Date.today.strftime("%A")
                  meal.active = false
                  else
                  meal.active = true
                  end
                elsif meal.restaurant.closing_day_two?
                  if meal.restaurant.closing_day_two == Date.today.strftime("%A")
                  meal.active = false
                  else
                  meal.active = true
                  end
                else
                  meal.active = true
                end
              end
                  meal.save
            end


    end

   task :empty_basket => :environment do
        @orders = Order.where("created_at < ? AND status = ?", Time.now - 5, "cart")
        @orders.each do |order|
        order.update(status:"cancelled")
        order.meal.stock += order.quantity
        order.meal.save
        end
    end

     task :update_permanent_quantity => :environment do
        @meal =  Meal.where(permanent:true)
        @meals.each do |meal|
        meal.stock = meal.quantity
        meal.save
        end
    end


    # task :send_notification => :environment do
    #     @all_meals = Meal.all
    #     @meals = @all_meals.where("active = ?", true)
    #     @all_users = User.all
    #     @users = @all_users.where("notification = ?", true)
    #     @meals.each do |meal|
    #       @users.each do |user|
    #         if
    #           user.postal_code == meal.restaurant.postal_code
    #           @deliver_notification == true
    #           meal_to_send = meal
    #           @meals_to_send = []
    #           @meals_to_send << meal_to_send
    #         end
    #       end
    #     end
    #     if @deliver_notification == true
    #     meal = @meals_to_send.first
    #     UserMailer.notification_mail(self, meal).deliver_now
    #     end
    # end



end
