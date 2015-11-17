class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant


  has_many :order_meals
  monetize :amount_cents
  validates :status, inclusion: { in: [ "cart", "paid", "cancel"] }

  def paid(user, json)



    # Sauvegarde du json provenant de stripe
    # passe le statut de la commande a paid
    # @order.update(payment: charge.to_json, status: 'paid')


    # reflete la commande sur le stock.

  end
end

