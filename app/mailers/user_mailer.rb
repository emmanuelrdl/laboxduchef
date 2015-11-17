class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome_owner(user)
    @user = current_user
    @greeting = "Bonjour"
    # mail to: "to@example.org"
    mail(to: @user.email, subject: 'Inscription sur La Box Du Chef')
  end

  def welcome_customer(user)
    @user = current_user
    @greeting = "Bonjour cher(e) client(e)"
    # mail to: "to@example.org"
    mail(to: @user.email, subject: 'Bienvenue sur La Box Du Chef')
  end

end
