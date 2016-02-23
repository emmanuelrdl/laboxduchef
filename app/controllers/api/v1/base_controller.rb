
  class Api::V1::BaseController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_filter :verify_authenticity_token
    before_filter :cors_preflight_check
    after_filter :cors_set_access_control_headers
    respond_to :json
    acts_as_token_authentication_handler_for User
    before_filter :authenticate_user_from_token!
    # before_filter :authenticate_user!

    private

     

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, X-User-Token, X-User-Email'
      headers['Access-Control-Max-Age'] = "1728000"
    end




    def cors_preflight_check
      if request.method == 'OPTIONS'
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, , X-User-Token, X-User-Email'
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '', :content_type => 'text/plain'
      end
    end


  protected
    def authenticate_user_from_token!
      authenticate_or_request_with_http_token do |token|
        user = User.find_by(authentication_token: token)
        sign_in(user, store: false)
      end
    end

    

  end
