class Api::V1::RestaurantsController < Api::V1::BaseController
  before_action :set_restaurant, only: [:show, :update, :destroy]


  def create
    @restaurant = Restaurant.new(params_restaurant)
    @restaurant.confirmed = false
    @restaurant = current_user.restaurants.create(params_restaurant)
      if @restaurant.save
        render :json => {:state => {:code => 0}, :data => @restaurant }
      else
        render :json => {:state => {:code => 1, :messages => @restaurant.errors.full_messages} }
      end
  end


  def update
    @restaurant.update(params_restaurant)
    if @restaurant.save
      render :json => {:state => {:code => 0}, :data => @restaurant }
    else
      render :json => {:state => {:code => 1, :messages => @restaurant.errors.full_messages} }
    end
  end




private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def params_restaurant
    params.require(:restaurant).permit(:name, :category, :street, :locality, :postal_code, :picture, :phone_number,
     :iban, :picture, :latitude, :longitude, :take_away_evening_ends_at, :take_away_noon_starts_at, :take_away_evening_starts_at,
      :take_away_noon_ends_at, :open_noon, :open_evening, :closing_day_one, :closing_day_two)
  end
end

