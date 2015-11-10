# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number, :restaurant_owner)
  end
end
