class MealsController < ApplicationController
  include Pundit
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show, :mealmapxs]
  before_action :set_restaurant, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_meal, only: [ :edit, :update, :destroy]
  before_action :navbar_choice
  before_action :disable_footer, only: [:mealmapxs]
  before_action :set_address, only: [:index, :show, :mealmapxs]
  after_action :verify_authorized, only: [:edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


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
    display_validity_date
    if @meal.active == false
      flash[:alert] = "Cette offre n'est plus valable"
    end
  end


  def edit
    authorize @meal
  end

  def update
    @meal = @restaurant.meals.find(params[:id])
    @meal.update(params_meal)
    @meal.stock = @meal.quantity
    if @meal.save
      redirect_to user_path(current_user)
    else
      render :edit
    end
    authorize @meal
  end


  def new
    @meal = Meal.new
    @restaurant = current_user.restaurants.first
    authorize @meal
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
    authorize @meal
  end



  def destroy
    @meal = @restaurant.meals.find(params[:id])
    @meal.update(active:false, permanent:false, starting_date:nil, second_date: Date.today - 2)
    if @meal.save
       flash[:notice] = "Offre désactivée avec succès"
       redirect_to user_path(current_user)
    else
      render :edit
    end
    authorize @meal
  end

  # def post_last_meal
  #  @last_meal = current_user.restaurants.first.meals.last
  #   if @last_meal.permanent?
  #     @last_meal.update(stock: @last_meal.quantity, active:true)
  #   elsif @last_meal.starting_date.present? && @last_meal.second_date.present?
  #     @last_meal.update(stock: @last_meal.quantity, active:true, starting_date: Date.today, second_date: Date.today + 1)
  #   elsif @last_meal.starting_date.present?
  #     @last_meal.update(stock: @last_meal.quantity, active:true, starting_date: Date.today)
  #   elsif @last_meal.second_date.present?
  #     @last_meal.update(stock: @last_meal.quantity, active:true, starting_date: Date.today + 1)
  #   end
  #   if @last_meal.save
  #     flash[:notice] = 'Offre publiée'
  #     redirect_to user_path(current_user)
  #   else
  #     flash[:alert] = 'Impossible de republier une offre supprimée'
  #     redirect_to user_path(current_user)
  #   end
  # end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end


  def params_meal
    params.require(:meal).permit(:name, :description, :price, :seated_price, :quantity, :picture, :starting_date,
    :restaurant_id, :active, :second_date, :take_away_noon, :take_away_evening, :permanent)
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

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisés à effectuer cette action."
    redirect_to(root_path)
  end

  def display_validity_date
    if @meal.starting_date == Date.today
      @date = "Aujoud'hui"
    elsif @meal.second_date == Date.today + 1
      @date = "Demain"
    elsif @meal.second_date == Date.today
      @date = "Aujourd'hui"
    elsif @meal.permanent == true
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



end
