class UserMailer < ApplicationMailer

  def welcome(user)

    @user = user  # Instance variable => available in view
    mail(to: @user.email, subject: 'Bienvenue sur La Box du Chef')
    # This will render a view in `app/views/user_mailer`!
  end


   def welcome_partner(user)

    @user = user  # Instance variable => available in view
    mail(to: @user.email, subject: 'Bienvenue sur La Box du Chef')
    # This will render a view in `app/views/user_mailer`!
  end


  def notification_mail(user, meal)
    @user = user
    @meal = meal
    mail(to: @user.email, subject: 'La carte du jour')
  end

end
