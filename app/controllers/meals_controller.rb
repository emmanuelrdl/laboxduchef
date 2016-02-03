class MealsController < ApplicationController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show, :mealmapxs]
  before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy ]
  before_action :set_meal, only: [ :edit, :update, :destroy]
  before_action :navbar_choice
  before_action :disable_footer, only: [:mealmapxs]
  before_action :set_address, only: [:index, :show, :mealmapxs]


  def index
    @meal = Meal.new
    @meals = Meal.where(active:true).paginate(:page => params[:page], :per_page => 6)
    where_group = params[:full_addressuser_input_autocomplete_address]
    if where_group
    @meals = Meal.where(active:true).joins(:restaurant).near(params[:full_addressuser_input_autocomplete_address], 20, order: 'distance').paginate(:page => params[:page], :per_page => 6)
    end
      @markers = Gmaps4rails.build_markers(@meals) do |meal, marker|
      @my_meal = meal.restaurant
      marker.lat meal.restaurant.latitude
      marker.lng meal.restaurant.longitude
      marker.infowindow render_to_string(:partial => 'meals/infowindow', :locals => { :object => @my_meal})
      marker.picture({
       :url => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=B|278F75|FFFFFF",
       :width   => 32,
       :height  => 32
      })
      end
  end

  def mealmapxs
    @meals = Meal.where(active:true)
    @markers = Gmaps4rails.build_markers(@meals) do |meal, marker|
    @my_meal = meal.restaurant
    marker.lat meal.restaurant.latitude
    marker.lng meal.restaurant.longitude
    marker.infowindow render_to_string(:partial => 'meals/infowindow', :locals => { :object => @my_meal})
    marker.picture({
     :url => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=B|278F75|FFFFFF",
     :width   => 32,
     :height  => 32
    })
    end
  end



  def show
    @meal = Meal.find(params[:id])
    @restaurant_coordinates = [{ lat: @meal.restaurant.latitude, lng: @meal.restaurant.longitude }]
    if @meal.active == false
      flash[:alert] = "Cette offre n'est plus valable"
    end
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
    @restaurant = current_user.restaurants.first
  end


  def create
    @meal = @restaurant.meals.create(params_meal)
    @meal.active = true
    @meal.stock = @meal.quantity
      if @meal.save
        flash[:notice] = 'Offre publiée'
        redirect_to user_path(current_user)
        send_new_meal_text
      else
        render :new
       end
  end



  def destroy
    @meal = @restaurant.meals.find(params[:id])
    @meal.update(active:false)
    if @meal.save
       flash[:notice] = 'Offre désactivée'
       redirect_to user_path(current_user)
    else
      render :edit
    end
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

  def navbar_choice
  @navbar_home = false
  end

  def disable_footer
    @disable_footer = true
  end

  def set_address
    @search_address = params[:full_addressuser_input_autocomplete_address]
  end

  def send_new_meal_text
    blowerio = RestClient::Resource.new(ENV['BLOWERIO_URL'])
    blowerio['/messages'].post :to => "+33663436165", :message => "LA BOX DU CHEF - Nouvelle offre"
    rescue
  end

end
