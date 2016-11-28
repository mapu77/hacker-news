class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate
    @user = User.where(oauth_token: request.headers['token'])
    @flag = 0
    if @user[0] == nil
      render :json => {"Error": "Unauthorized user"}.to_json, status: 401
      @flag = 1
    end
  end
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
end
