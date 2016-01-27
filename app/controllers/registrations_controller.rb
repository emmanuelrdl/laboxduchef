# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :navbar_choice
  skip_before_filter :verify_authenticity_token, :only => :create

  def after_sign_up_path_for(resource)
    if resource.restaurant_owner
      root_path
    else
      root_path
    end
  end


  def create
  build_resource(sign_up_params)
  if @user.restaurant_owner?
       resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      redirect_to partner_sign_up_path(sign_up_params)
      flash[:alert] = "Certains champs sont incorrects"
    end

  else
      resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end


  end

  def new_partner

    @user = User.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], phone_number: params[:phone_number])
  end


  private

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number,
     :restaurant_owner, :notification, :postal_code, :locality, :street, :cgv)
  end


  def navbar_choice
    @navbar_other = true
  end



end
