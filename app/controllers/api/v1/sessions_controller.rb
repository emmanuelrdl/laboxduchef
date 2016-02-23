
  class Api::V1::SessionsController < Devise::SessionsController
      skip_before_filter  :verify_authenticity_token
      protect_from_forgery with: :null_session , :if => Proc.new { |c| c.request.format == 'application/json' }
      respond_to :json
      before_filter :cors_preflight_check
      after_filter :cors_set_access_control_headers


   def create
     self.resource = warden.authenticate!(auth_options)
     sign_in(resource_name, resource)
     current_user.update authentication_token: nil
         render :json => {
           :user => current_user,
           :status => :ok,
           :authentication_token => current_user.authentication_token,
           :email => current_user.email,
           :id => current_user.id
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


 def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end




  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end


  end

