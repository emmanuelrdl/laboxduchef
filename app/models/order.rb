class Order < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants
  belongs_to :meal


  validates :quantity, presence: true
  validates :quantity, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100 }
  validates_numericality_of :quantity, :only_integer => true
  validates :user_id, presence: true
  validates :meal_id, presence: true

  monetize :amount_cents





end

