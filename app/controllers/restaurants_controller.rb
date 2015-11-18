class RestaurantsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    if current_user.restaurants(params[:id]).count >= 1
         flash[:alert] = "Vous ne pouvez avoir qu'un restaurant"
         redirect_to root_path
    else
      @restaurant = Restaurant.new
    end
  end

  def create
    @restaurant = Restaurant.new(params_restaurant)
    @restaurant.user = current_user
    @restaurant.confirmed = false



    @restaurant = current_user.restaurants.build(params_restaurant)

    if @restaurant.save
      # RestaurantMailer.creation_confirmation(@restaurant).deliver_now
      redirect_to user_path(current_user)
    else
      render :new
    end
  end



  def edit

  end

  def update
    @restaurant.user = current_user
    current_user.restaurant.update(params_restaurant)
    if @restaurant.save
    redirect_to user_path(current_user)
    else
    render :edit
    end

  end



  def show
  end


  def destroy
  end

private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def params_restaurant
    params.require(:restaurant).permit(:name, :category, :street, :locality, :postal_code, :picture, :phone_number,
     :iban, :picture, :latitude, :longitude)
  end
end
