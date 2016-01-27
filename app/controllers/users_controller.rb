class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  before_action :navbar_choice


  def show
    @last_order = current_user.orders.where(status: 'confirmed' || 'paid').last
    @restaurants = current_user.restaurants
    if current_user.restaurant_owner
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals
    elsif current_user.orders.where(status:'confirmed' || 'paid').count >= 1 && current_user.orders.last.status == 'confirmed' || 'paid'
      @last_order = current_user.orders.where(status: 'confirmed' || 'paid').last
      @restaurant_full_address = current_user.orders.where(status:"confirmed" || 'paid').last.meal.restaurant.full_address
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
