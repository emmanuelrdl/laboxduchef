class Meal < ActiveRecord::Base
  belongs_to :restaurant

  reverse_geocoded_by "restaurants.latitude", "restaurants.longitude"
  has_many :orders

  validates :picture, presence: true, :on => :create
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: true
  validates :price, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :seated_price, presence: true, numericality: true
  validates :seated_price, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :quantity, presence: true, numericality:  {:greater_than_or_equal_to => 1 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :starting_date, presence: true, unless: ->(meal){meal.second_date.present? || meal.permanent.present?}
  validates :permanent, presence: true, unless: ->(meal){meal.starting_date.present? || meal.second_date.present?}
  validates :second_date, presence: true, unless: ->(meal){meal.starting_date.present? || meal.permanent.present?}
  validates :take_away_noon, presence: true, unless: ->(meal){meal.take_away_evening.present?}
  validates :take_away_evening, presence: true, unless: ->(meal){meal.take_away_noon.present?}

  paginates_per 6

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>", large: "400x400>", facebook:"600x315>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  monetize :price_cents
  monetize :seated_price_cents

  def starting_date_exception?
    if second_date.present?
    elsif permanent == true
    end
    true
  end


  def second_date_exception?
    if starting_date.present?
    elsif permanent == true
    end
    true
  end


  def permanent_exception?
    if starting_date.present?
    elsif second_date.present?
    end
    true
  end

end


