
class Api::V1::PaymentsController < Api::V1::BaseController

    

  def create
    @amount = @order.amount_cents
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email: params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount:       @amount,  # in cents
      description:  "Payement d'une portion ",
      currency:     'eur'
    )
    @order.update(payment: charge.to_json, status: 'confirmed')
    @order = current_user.orders.where(status: "confirmed")
    send_order_confirmation
    redirect_to cart_payment_path(@order)
    rescue Stripe::CardError => e
    flash[:error] = e.message
  end





  private

    def sign_up_params
      params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number,
       :restaurant_owner, :notification, :postal_code, :locality, :street, :cgv)
    end

end

