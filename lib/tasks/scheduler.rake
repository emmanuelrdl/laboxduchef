
namespace :scheduler do

    task :update_meal_active => :environment do

    end

   task :empty_basket => :environment do
        @orders = Order.where("created_at > ? AND status = ?", Time.now + 5, "cart")
        @orders.each do |order|
        order.update(status:"cancelled")
        order.meal.stock += order.quantity
        order.meal.save
        end
    end

     task :update_permanent_quantity => :environment do
        @meals =  Meal.where("permanent = ?", true)
        @meals.each do |meal|
        meal.stock = meal.quantity
        meal.save
        end
    end


    task :update_permanent_quantity => :environment do
      @meals = Meal.all
      @meals.each do |meal|
            if meal.second_date?
              if
                meal.second_date < Date.today
                meal.active = false
              else
                meal.active = true
              end
              meal.save
            elsif meal.starting_date?
              if
                meal.starting_date < Date.today
                meal.active = false
              else
                meal.active = true
              end
              meal.save
             elsif meal.permanent? && meal.stock >= 0
              if meal.restaurant.closing_day_one? && meal.restaurant.closing_day_two?
                if meal.restaurant.closing_day_one == Date.today.strftime("%A") || meal.restaurant.closing_day_two == Date.today.strftime("%A")
                meal.active = false
                else
                meal.active = true
                end
              meal.save
              elsif meal.restaurant.closing_day_one?
                if meal.restaurant.closing_day_one == Date.today.strftime("%A")
                meal.active = false
                else
                meal.active = true
                end
              meal.save
              elsif meal.restaurant.closing_day_two?
                if meal.restaurant.closing_day_two == Date.today.strftime("%A")
                meal.active = false
                else
                meal.active = true
                end
              meal.save
              elsif (meal.restaurant.closing_day_one == (Date.today + 1).strftime("%A")) || (meal.restaurant.closing_day_two == (Date.today + 1).strftime("%A"))
                if (meal.restaurant.take_away_noon_starts_at != meal.restaurant.take_away_noon_ends_at) && (meal.restaurant.take_away_evening_starts_at != meal.restaurant.take_away_evening_ends_at)
                    if meal.restaurant.take_away_evening_ends_at.strftime("%H%M") < Time.now.strftime("%H%M")
                      meal.active = false
                    else
                      meal.active = true
                    end
                    meal.save
                elsif meal.restaurant.take_away_noon_starts_at != meal.restaurant.take_away_noon_ends_at
                    if meal.restaurant.take_away_noon_ends_at.strftime("%H%M") < Time.now.strftime("%H%M")
                      meal.active = false
                    else
                      meal.active = true
                    end
                    meal.save
                elsif meal.restaurant.take_away_evening_starts_at != meal.restaurant.take_away_evening_ends_at
                  if meal.restaurant.take_away_evening_ends_at.strftime("%H%M") < Time.now.strftime("%H%M")
                      meal.active = false
                  else
                      meal.active = true
                  end
                  meal.save
              else
                meal.active = true
              end
            end
          end
        end
      end




end
