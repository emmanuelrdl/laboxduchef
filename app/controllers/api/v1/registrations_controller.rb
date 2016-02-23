
  class Api::V1::RegistrationsController < Devise::RegistrationsController

    respond_to :json
    protect_from_forgery with: :null_session , :if => Proc.new { |c| c.request.format == 'application/json' }

    def create
      @user = User.create(sign_up_params)
      if @user.save
        render :json => {:state => {:code => 0}, :auth_token=>user.authentication_token, :email=>user.email}
      else
        render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
      end
    end




  private

    def sign_up_params
      params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :last_name, :phone_number,
       :restaurant_owner, :notification, :postal_code, :locality, :street, :cgv)
    end

  end

