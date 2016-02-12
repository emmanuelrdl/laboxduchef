class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  before_action :navbar_choice



  def show
    if current_user.restaurant_owner
      @restaurants = current_user.restaurants
      @restaurant = current_user.restaurants.first
      @meals = @restaurant.meals.where("active = ?", true)
      @orders = []
      @meals.each do |meal|
        meal.orders.each do |meal_order|
         @orders << meal_order
        end
      end
    else
      if current_user.orders.where(status:'confirmed').count >= 1 || current_user.orders.where(status:'paid').count >= 1
        set_last_order_status
        set_validity_date
        set_take_away_time
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



  def set_last_order_status
    if (current_user.orders.where("status = ?", 'confirmed').count >= 1)  || (current_user.orders.where("status = ?", 'paid').count >= 1)
      if current_user.orders.last.status == "confirmed"
        @last_order = current_user.orders.where("status = ?",'confirmed').last
        @restaurant_full_address = @last_order.meal.restaurant.full_address
      elsif current_user.orders.last.status == "paid"
        @last_order = current_user.orders.where("status = ?", 'paid').last
        @restaurant_full_address = @last_order.meal.restaurant.full_address
      elsif current_user.orders.last.status == "cart"
          if current_user.orders.where("status = ?", 'confirmed').present? && current_user.orders.where("status = ?", 'paid').present?
             if current_user.orders.where("status = ?", 'confirmed').last.created_at > current_user.orders.where("status = ?", 'paid').last.created_at
                @last_order = current_user.orders.where("status = ?", 'confirmed').last
             else
                @last_order = current_user.orders.where("status = ?",'paid').last
             end
          elsif current_user.orders.where("status = ?", 'confirmed').present?
              @last_order = current_user.orders.where("status = ?", 'confirmed').last
          elsif current_user.orders.where("status = ?", 'paid').present?
              @last_order = current_user.orders.where("status = ?",'paid').last
          end
      elsif current_user.orders.last.status == "cancelled"
        if current_user.orders.where("status = ?",'confirmed').present? && current_user.orders.where("status = ?", 'paid').present?
             if current_user.orders.where("status = ?",'confirmed').last.created_at > current_user.orders.where("status = ?",'paid').last.created_at
                @last_order = current_user.orders.where("status = ?", 'confirmed').last
             else
                @last_order = current_user.orders.where("status = ?", 'paid').last
             end
        elsif current_user.orders.where("status = ?", 'confirmed').present?
            @last_order = current_user.orders.where("status = ?", 'confirmed').last
        elsif current_user.orders.where("status = ?",'paid').present?
            @last_order = current_user.orders.where("status = ?", 'paid').last
        end
      end
    end
  end


  def set_validity_date
    @meal = @last_order.meal
    if @meal.starting_date == Date.today && @meal.second_date == Date.today + 1
      @date = "Aujourd'hui"
      @date_2 = "Demain"
    elsif @meal.starting_date == Date.today
      @date = "Aujoud'hui"
    elsif @meal.second_date == Date.today + 1
      @date = "Demain"
    elsif @meal.permanent == true && @last_order.created_at == Date.today
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


  def set_take_away_time
    if @last_order.meal.take_away_noon? && @last_order.meal.take_away_evening?
      @time_noon_starts =  @last_order.meal.restaurant.take_away_noon_starts_at.strftime('%H:%M')
      @time_noon_ends = @last_order.meal.restaurant.take_away_noon_ends_at.strftime('%H:%M')
      @time_evening_starts = @last_order.meal.restaurant.take_away_evening_starts_at.strftime('%H:%M')
      @time_evening_ends = @last_order.meal.restaurant.take_away_evening_ends_at.strftime('%H:%M')
    elsif @last_order.meal.take_away_noon?
      @time_noon_starts = @last_order.meal.restaurant.take_away_noon_starts_at.strftime('%H:%M')
      @time_evening_ends = @last_order.meal.restaurant.take_away_noon_ends_at.strftime('%H:%M')
    elsif @last_order.meal.take_away_evening?
      @time_evening_starts = @last_order.meal.restaurant.take_away_evening_starts_at.strftime('%H:%M')
      @time_evening_ends = @last_order.meal.restaurant.take_away_evening_ends_at.strftime('%H:%M')
    end
  end


end
