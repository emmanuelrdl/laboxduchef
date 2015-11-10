class RestaurantsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params_restaurant)
    @restaurant.user_id = current_user.id
      if @restaurant.save
        redirect_to restaurants_path #provisoire,à rediriger
      else
        render :new
      end
  end

  def edit

  end

  def update
    @restaurant.name = params_restaurant[:name]
    @restaurant.phone_number = params_restaurant[:sport]
    @restaurant.category = params_restaurant[:category]
    @restaurant.picture = params_restaurant[:picture]
    @restaurant.address = params_restaurant[:address]
    @restaurant.city = params_restaurant[:city]
    @restaurant.zip_code = params_restaurant[:zip_code]
    @restaurant.iban = params_restaurant[:iban]
    @restaurant.save
    redirect_to restaurants_path #provisoire,à rediriger
  end



  def show
  end


  def delete
  end

private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def params_restaurant
    params.require(:restaurant).permit(:name,:user_id, :category, :address, :city, :zip_code, :picture, :phone_number,
     :iban, :address, :picture, :latitude, :longitude)
  end



end
