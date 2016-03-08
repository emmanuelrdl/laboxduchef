class Api::V1::RestaurantsController < Api::V1::BaseController
  before_action :set_restaurant, only: [:show, :update, :destroy]


  def create
   
    
    @restaurant = current_user.restaurants.create(params_restaurant)
    @restaurant.confirmed = false
      if @restaurant.save
        render :json => {:state => {:code => 0}, :data => @restaurant }
      else
        render :json => {:state => {:code => 1, :messages => @restaurant.errors.full_messages} }
      end
  end


  def update
    @restaurant.update(params_restaurant)
    if @restaurant.save
      render :json => {:state => {:code => 0}, :data => @restaurant }
    else
      render :json => {:state => {:code => 1, :messages => @restaurant.errors.full_messages} }
    end
  end

  def s3_access_token
      render json: {
        policy:    s3_upload_policy,
        signature: s3_upload_signature,
        key:       ENV['MOBILE_AWS_ACCESS_KEY_ID']
      }
  end

  protected

  def s3_upload_policy
    @policy ||= create_s3_upload_policy
  end

  def create_s3_upload_policy
    Base64.encode64(
      {
        "expiration" => 1.hour.from_now.utc.xmlschema,
        "conditions" => [
          { "bucket" =>  ENV['MOBILE_S3_BUCKET_NAME'] },
          [ "starts-with", "$key", "" ],
          { "acl" => "public-read" },
          [ "starts-with", "$Content-Type", "" ],
          [ "content-length-range", 0, 10 * 1024 * 1024 ]
        ]
      }.to_json).gsub(/\n/,'')
  end

  def s3_upload_signature
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), ENV['MOBILE_AWS_SECRET_ACCESS_KEY'], s3_upload_policy)).gsub("\n","")
  end




private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def params_restaurant
    params.require(:restaurant).permit(:name, :category, :street, :locality, :postal_code, :picture, :phone_number,
     :iban, :picture, :latitude, :longitude, :take_away_evening_ends_at, :take_away_noon_starts_at, :take_away_evening_starts_at,
      :take_away_noon_ends_at, :open_noon, :open_evening, :closing_day_one, :closing_day_two, :picture_file_name)
  end
end

