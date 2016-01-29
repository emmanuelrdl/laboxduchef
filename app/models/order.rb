class Order < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants
  belongs_to :meal


  validates :quantity, presence: true
  validates :user_id, presence: true
  validates :meal_id, presence: true
  validates_numericality_of :quantity, :only_integer => true

  monetize :amount_cents





end

