class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Bonjour"
    # mail to: "to@example.org"
    mail(to: @user.email, subject: 'Bienvenue sur La Box Du Chef')
  end

  def subscrib(user)
    @user = user
    @greeting = "Bonjour"
    # mail to: "to@example.org"
    mail(to: @user.email, subject: 'Inscription sur La Box Du Chef')
  end

end
