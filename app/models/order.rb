class Order < ActiveRecord::Base
  belongs_to :user
  has_many :restaurants
  belongs_to :meal



  monetize :amount_cents



end

