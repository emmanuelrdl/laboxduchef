class Meal < ActiveRecord::Base
  belongs_to :restaurant

  # validates :picture, presence: true
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true
  # validates :starting_date, presence: true

  # validates :take_away_noon_starts_at, presence: true
  # validates :take_away_evening_starts_at, presence: true
  # validates :take_away_noon_ends_at, presence: true
  # validates :take_away_evening_ends_at, presence: true

  paginates_per 6
end
