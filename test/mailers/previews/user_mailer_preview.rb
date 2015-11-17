class UserMailerPreview < ActionMailer::Preview

  def welcome_owner
    user = User.first
    UserMailer.welcome_owner(user)
  end

  def welcome_customer
    user = User.first
    UserMailer.welcome_customer(user)
  end

end
