class Meal < ActiveRecord::Base
  belongs_to :restaurant

  reverse_geocoded_by "restaurants.latitude", "restaurants.longitude"
  has_many :order_meals

  validates :picture, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true
  validates :seated_price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true, length: { maximum: 100 }
  validates :take_away_noon_starts_at, presence: true
  validates :take_away_evening_starts_at, presence: true
  validates :take_away_noon_ends_at, presence: true
  validates :take_away_evening_ends_at, presence: true
  validates :starting_date, presence: true, unless: ->(meal){meal.second_date.present?}
  validates :second_date, presence: true, unless: ->(meal){meal.starting_date.present?}

  paginates_per 6

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>", large: "400x400>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  monetize :price_cents




end
