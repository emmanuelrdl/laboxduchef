
  class Api::V1::MealsController < Api::V1::BaseController
    acts_as_token_authentication_handler_for User, except: [ :index, :show ]
    before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_meal, only: [ :edit, :update, :destroy, :show]
    include Pundit


    def index
      @meals = Meal.where("active = ?", true)
    end


    def show
      @meal = Meal.find(params[:id])
      @restaurant_coordinates = [{ lat: @meal.restaurant.latitude, lng: @meal.restaurant.longitude }]
      display_validity_date
    end

    def create
      @meal = @restaurant.meals.create(params_meal)
      @meal.active = true
      @meal.stock = @meal.quantity
      if @meal.save
        render :json => {:state => {:code => 0}, :data => @meal }
      else
        render :json => {:state => {:code => 1, :messages => @meal.errors.full_messages} }
      end
      authorize @meal
    end

    def update
      @meal = @restaurant.meals.find(params[:id])
      @meal.update(params_meal)
      @meal.stock = @meal.quantity
      if @meal.save
        render :json => {:state => {:code => 0}, :data => @meal }
      else
        render :json => {:state => {:code => 1, :messages => @meal.errors.full_messages} }
      end
      authorize @meal
    end

    def destroy
      @meal = @restaurant.meals.find(params[:id])
      @meal.update(active:false, permanent:false, starting_date:nil, second_date: Date.today - 2)
      if @meal.save
        render :json => {:state => {:code => 0}, :data => @meal }
      else
         render :json => {:state => {:code => 1, :messages => @meal.errors.full_messages} }
      end
      authorize @meal
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

