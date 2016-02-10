module Api
  class MealsController < Api::BaseController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:index, :show]
    before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_meal, only: [ :edit, :update, :destroy, :show]

    def index
      @meals = Meal.where(active:true)
    end

    def show
    end


    def create
      @meal = @restaurant.meals.create(params_meal)
      @meal.active = true
      @meal.stock = @meal.quantity
      @meal.save
    end
    private

    def params_meal
      params.require(:meal).permit(:name, :description, :price, :seated_price, :quantity, :picture, :starting_date,
      :restaurant_id, :active, :second_date, :take_away_noon, :take_away_evening, :permanent)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_meal
      @meal = Meal.find(params[:id])
    end

    def query_params
      params.permit(:restaurant_id, :name)
    end



    def display_validity_date
      if @meal.starting_date == Date.today
        @date = "Aujoud'hui"
      elsif @meal.second_date == Date.today + 1
        @date = "Demain"
      elsif @meal.second_date == Date.today
        @date = "Aujourd'hui"
      elsif @meal.permanent == true
        if (@meal.restaurant.take_away_noon_ends_at != @meal.restaurant.take_away_noon_starts_at) &&  (@meal.restaurant.take_away_evening_ends_at != @meal.restaurant.take_away_evening_starts_at)
          if @meal.restaurant.take_away_evening_ends_at.strftime("%H%M") > Time.now.strftime("%H%M")
              @date = "Aujourd'hui"
          else
              @date = "Demain"
          end
        elsif @meal.restaurant.take_away_noon_ends_at != @meal.restaurant.take_away_noon_starts_at
          if @meal.restaurant.take_away_noon_ends_at.strftime("%H%M") > Time.now.strftime("%H%M")
              @date = "Aujourd'hui"
          else
              @date = "Demain"
          end
        elsif @meal.restaurant.take_away_evening_ends_at != @meal.restaurant.take_away_evening_starts_at
          if @meal.restaurant.take_away_evening_ends_at.strftime("%H%M") > Time.now.strftime("%H%M")
              @date = "Aujourd'hui"
          else
              @date = "Demain"
          end
        else
          @date = "Offre terminée"
        end
      else
        @date = "Offre terminée"
      end
    end

  end
end
