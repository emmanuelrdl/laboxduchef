class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :navbar_choice, only: [:home]
  before_action :footer_choice, only: [:home, :espace_restaurants, :conditionsgenerales, :chartepartenaire,
    :charteutilisateur]

  def home
    @meals = Meal.all
    @restaurants = Restaurant.all
    @markers = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
    @my_restaurant = restaurant
    marker.lat restaurant.latitude
    marker.lng restaurant.longitude
    # marker.infowindow render_to_string(:partial => "/meals/infowindow")
    marker.infowindow render_to_string(:partial => 'pages/infowindow', :locals => { :object => @my_restaurant})
    end
    @newsletter = Newsletter.new
  end

  def home_partner
    if current_user != nil
      if current_user.restaurant_owner == true
        @restaurant = current_user.restaurants.first
        @newsletter = Newsletter.new
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def espace_restaurants
  end


  def conditionsgenerales
  end

  def chartepartenaire
  end

  def charteutilisateur
  end

 def navbar_choice
  @navbar_home = true
 end

 def footer_choice
  @footer_xs = true
 end


end
