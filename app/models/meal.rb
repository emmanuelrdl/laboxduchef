class Meal < ActiveRecord::Base
  belongs_to :restaurant
  has_many :order_meals

  # validates :picture, presence: true
  # validates :name, presence: true
  # validates :price, presence: true
  # validates :quantity, presence: true, inclusion: { in: 0..12}
  # validates :description, presence: true
  # validates :starting_date, presence: true
  # validates :take_away_noon_starts_at, presence: true
  # validates :take_away_evening_starts_at, presence: true
  # validates :take_away_noon_ends_at, presence: true
  # validates :take_away_evening_ends_at, presence: true

  paginates_per 6

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>", large: "400x400>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  monetize :price_cents




end
