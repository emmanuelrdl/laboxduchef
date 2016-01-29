class RestaurantsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:show, :update, :destroy]
  before_action :navbar_choice

  def index
    @restaurants = Restaurant.all
  end

  def new

    if current_user.restaurants(params[:id]).count >= 1
         flash[:alert] = "Vous ne pouvez avoir qu'un restaurant"
         redirect_to root_path
    elsif current_user.restaurant_owner == false
         flash[:alert] = "Vous n'êtes pas autorisés à créer un restaurant"
         redirect_to root_path

    else
      @restaurant = Restaurant.new
    end
  end

  def create
    @restaurant = Restaurant.new(params_restaurant)
    @restaurant.confirmed = false
    @restaurant = current_user.restaurants.create(params_restaurant)

       if @restaurant.save
        redirect_to user_path(current_user)
      else
        render :new
      end

  end



  def edit
      @restaurant = Restaurant.find(current_user.restaurants.first.id)
  end

  def update
    @restaurant.update(params_restaurant)
    if @restaurant.save
    redirect_to user_path(current_user)
    else
    render :edit
    end

  end



  def navbar_choice
    @navbar_other = true
  end

private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def params_restaurant
    params.require(:restaurant).permit(:name, :category, :street, :locality, :postal_code, :picture, :phone_number,
     :iban, :picture, :latitude, :longitude, :take_away_evening_ends_at, :take_away_noon_starts_at, :take_away_evening_starts_at,
      :take_away_noon_ends_at, :open_noon, :open_evening)
  end
end
