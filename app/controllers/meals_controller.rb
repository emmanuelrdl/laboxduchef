class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy ]
  before_action :set_meal, only: [ :edit, :update, :destroy]
  before_action :navbar_choice




  def index
    @meal = Meal.new
    @meals = Meal.all.paginate(:page => params[:page], :per_page => 6)
    where_group = params[:full_addressuser_input_autocomplete_address]
    if where_group
    @meals = Meal.joins(:restaurant).near(params[:full_addressuser_input_autocomplete_address], 20, order: 'distance').paginate(:page => params[:page], :per_page => 6)
    end


  @markers = Gmaps4rails.build_markers(@meals) do |meal, marker|
    @my_meal = meal.restaurant
    marker.lat meal.restaurant.latitude
    marker.lng meal.restaurant.longitude
    # marker.infowindow render_to_string(:partial => "/meals/infowindow")
    marker.infowindow render_to_string(:partial => 'meals/infowindow', :locals => { :object => @my_meal})

    # marker.picture({
    #   :url => ActionController::Base.helpers.asset_path('marker.png'),#{ }"http://placehold.it/30x30
    #   :width   => 28,
    #   :height  => 35
    #  })
   end
  end


  def show
    @meal = Meal.find(params[:id])
    @restaurant_coordinates = [{ lat: @meal.restaurant.latitude, lng: @meal.restaurant.longitude }]
  end


  def edit
  end

  def update

    @meal = @restaurant.meals.find(params[:id])
    @meal.update(params_meal)
    if @meal.save
    redirect_to user_path(current_user)
    else
    render :edit
    end
  end


  def new
    @meal = Meal.new
  end


  def create
    @meal = @restaurant.meals.create(params_meal)
    @meal.active = true
    @meal.stock = @meal.quantity
    if @meal.save
      redirect_to user_path(current_user)
    else
      render :new
     end
  end



  def destroy
    @meal = @restaurant.meals.find(params[:id])
    if @meal.delete
       redirect_to user_path(current_user)
    else
      render :destroy
    end
  end

   def navbar_choice
    @navbar_other = true
   end



  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])

  end

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def params_meal
    params.require(:meal).permit(:name, :description, :price, :seated_price, :quantity, :picture, :starting_date,
    :restaurant_id, :active, :second_date, :take_away_noon, :take_away_evening)
  end

end
