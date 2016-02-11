
  class Api::V1::SessionsController < Devise::SessionsController
      skip_before_filter  :verify_authenticity_token
      protect_from_forgery with: :null_session , :if => Proc.new { |c| c.request.format == 'application/json' }
      respond_to :json

   def create
     self.resource = warden.authenticate!(auth_options)
     sign_in(resource_name, resource)
     current_user.update authentication_token: nil
         render :json => {
           :user => current_user,
           :status => :ok,
           :authentication_token => current_user.authentication_token
         }
    end

    def destroy
       if current_user
         current_user.update authentication_token: nil
         signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
         render :json => {}.to_json, :status => :ok
       else
         render :json => {}.to_json, :status => :unprocessable_entity
       end
    end

  protected


  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end


  end

