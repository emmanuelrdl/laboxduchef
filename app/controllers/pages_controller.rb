class PagesController < ApplicationController
  skip_before_action :authenticate_user!
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
  end

  def espace_restaurants
  end

  def fonctionnement
  end

  def conditionsgenerales
  end

  def chartepartenaire
  end

  def charteutilisateur
  end


end
