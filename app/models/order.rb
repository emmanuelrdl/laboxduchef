class Order < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants


  has_many :order_meals
  monetize :amount_cents



end

