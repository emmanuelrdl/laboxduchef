class UserMailer < ApplicationMailer

  def welcome(user)

    @user = user  # Instance variable => available in view
    mail(to: @user.email, subject: 'Bienvenue sur La Box des Chefs')
    # This will render a view in `app/views/user_mailer`!
  end


   def welcome_partner(user)

    @user = user  # Instance variable => available in view
    mail(to: @user.email, subject: 'Bienvenue sur La Box des Chefs')
    # This will render a view in `app/views/user_mailer`!
  end


  def order_confirmation(user, amount, name, restaurant, quantity)
    @user = user
    @amount = amount
    @name = name
    @restaurant = restaurant
    @quantity = quantity
    mail(to: @user.email, subject: 'Confirmation de commande - La Box des Chefs')
  end

end
