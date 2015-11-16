class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_meals

  validates :status, inclusion: { in: [ "cart", "paid", "cancel"] }


end

