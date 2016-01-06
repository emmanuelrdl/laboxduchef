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
  validates :street, uniqueness: true
  validates :locality, presence: true
  validates :postal_code, presence: true
  validates :phone_number, presence: true
  validates :picture, presence: true
  validates :iban, presence: true
  validates :take_away_noon_starts_at, presence: true
  validates :take_away_evening_starts_at, presence: true
  validates :take_away_noon_ends_at, presence: true
  validates :take_away_evening_ends_at, presence: true

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?



  def full_address
    "#{street}, #{postal_code} #{locality}"
  end

  def full_address_changed?
    street_changed? || postal_code_changed? || locality_changed?
  end
end
