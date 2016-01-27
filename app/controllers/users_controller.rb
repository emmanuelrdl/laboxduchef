class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  before_action :navbar_choice


  def show
    if current_user.restaurant_owner
      @restaurants = current_user.restaurants
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals
    else
      if current_user.orders >= 1
        if current_user.orders.last.status == 'paid' || current_user.orders.last.status == 'confirmed'
          @last_order = current_user.orders.where(status: 'paid').last || current_user.orders.where(status: 'confirmed').last
          @restaurant_full_address = @last_order.meal.restaurant.full_address
        elsif current_user.orders.last.status == "cart" || current_user.orders.last.status == "cancelled"
          if current_user.orders.where(status:"confirmed" || 'paid').count >= 1
             @last_order = current_user.orders.where(status:'paid' || 'confirmed').last
          end
        end
      end
    end
  end



  private

  def navbar_choice
    @navbar_other = true
  end

  def set_user
    @user = User.find(params[:id])
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number,
     :restaurant_owner, :notification, :postal_code, :locality, :street, :cgv)
  end

end
