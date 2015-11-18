class RestaurantMailer < ApplicationMailer
  def creation_confirmation(restaurant)
    @restaurant = restaurant

    mail(
      to:       @restaurant.user.email,
      subject:  "Restaurant #{@restaurant.name} created!"
    )
  end
end
