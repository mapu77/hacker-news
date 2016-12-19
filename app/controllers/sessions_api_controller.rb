class SessionsApiController < ApplicationController
    before_action :authenticate
    after_action :cors_set_access_control_headers
    
    def show_sessions
    @usuari = User.where(id: params[:id])
    authenticate()
    if @flag == 0
      if @usuari[0] == nil
        render :json => {"Error": "User not found"}.to_json, status: 404
      else
        render_user(@usuari[0], 200)
      end
    end
  end
  
  def update_sessions
    @usuari = User.where('id=? OR uid=?', params[:id], params[:id].to_s)
    authenticate()
    if @flag == 0
      if @usuari[0].id != @user[0].id
        render :json => {"Error": "Unauthorized user"}.to_json, status: 401
      elsif @usuari[0] == nil
        render :json => {"Error": "User not found"}.to_json, status: 404
      else
        @usuari.update(user_params_api)
        render_user(@usuari[0], 200)
      end
    end
  end
  
  private
  
    def user_params_api
         params.permit(:about, :token)
    end
  
    def render_user(user, status)
      render :json => {
          id: user.id,
          name: user.name,
          about: user.about,
          created_at: user.created_at,
          token: user.oauth_token
        }.to_json, status: status
    end
    
end