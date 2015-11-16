class UserMailerPreview < ActionMailer::Preview
  def welcome
    if current_user.restaurant_owner
      restaurant = Restaurant.first
      RestaurantMailer.welcome(restaurant)
    else
      user = User.first
      UserMailer.welcome(user)
  end
end
