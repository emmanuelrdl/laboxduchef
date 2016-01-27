class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  before_action :navbar_choice


  def show
    if current_user.restaurant_owner
      @restaurants = current_user.restaurants
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals
    elsif (current_user.orders.where(status:'confirmed').count  || current_user.orders.where(status:'paid').count) >= 1
      if current_user.orders.last.status == "confirmed"
        @last_order = current_user.orders.where(status: 'confirmed').last
        @restaurant_full_address = @last_order.meal.restaurant.full_address
      elsif current_user.orders.last.status == "paid"
        @last_order = current_user.orders.where(status: 'paid').last
        @restaurant_full_address = @last_order.meal.restaurant.full_address
      elsif current_user.orders.last.status == "cart"
        if current_user.orders.where(status:"confirmed").last.created_at > current_user.orders.where(status:"paid").last.created_at
          @last_order = current_user.orders.where(status: 'confirmed').last
        else
          @last_order = current_user.orders.where(status: 'paid').last
        end
      elsif current_user.orders.last.status == "cancelled"
        if current_user.orders.where(status:"confirmed").last.created_at > current_user.orders.where(status:"paid").last.created_at
          @last_order = current_user.orders.where(status: 'confirmed').last
        else
          @last_order = current_user.orders.where(status: 'paid').last
        end
      end
    end
  end

  def navbar_choice
    @navbar_other = true
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number,
     :restaurant_owner, :notification, :postal_code, :locality, :street, :cgv)
  end

end
