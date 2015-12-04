# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    if resource.restaurant_owner
      root_path
    else
      root_path
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number,
     :restaurant_owner, :notification, :postal_code, :locality, :street, :cgv)
  end

  def new_partner

  end


end
