class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :meals, dependent: :destroy
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }
  has_many :orders

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/


  validates :name, presence: true
  validates :name, uniqueness: true
  validates :locality, presence: true
  validates :postal_code, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :phone_number, presence: true
  validates :phone_number, numericality: true
  validates :picture, presence: true
  validates :picture_file_name, presence: true, unless: ->(restaurant){restaurant.picture_file_name.present?}
  validates :iban, presence: true
  validates :take_away_noon_starts_at, presence: true
  validates :take_away_evening_starts_at, presence: true
  validates :take_away_noon_ends_at, presence: true
  validates :take_away_evening_ends_at, presence: true
  validates :open_noon, presence: true,  unless: ->(restaurant){restaurant.open_evening == true}
  validates :open_evening, presence: true,  unless: ->(restaurant){restaurant.open_noon == true}

  geocoded_by :full_address
  before_validation :geocode, if: :full_address_changed?


  after_create :send_restaurant_created

  ALL_DAYS = [ ["Lundi","Monday"], ["Mardi","Tuesday"], ["Merci","Wednesday"], ["Jeudi","Thursday"], ["Vendredi","Friday"], ["Samedi","Saturday"], ["Dimanche","Sunday"]]


 def send_restaurant_created
    restaurant = Restaurant.last
    user = Restaurant.last.user
    UserMailer.restaurant_created(restaurant, user).deliver_now
 end



  def full_address
    "#{street}, #{postal_code} #{locality}"
  end

  def full_address_changed?
    street_changed? || postal_code_changed? || locality_changed?
  end



end
