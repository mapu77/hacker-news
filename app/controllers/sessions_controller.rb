class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  # def update
  #   respond_to do |format|
  #     if @Session.update(user_params)
  #       format.html { redirect_to @Session, notice: 'Contribution was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @Session }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @Session.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
  # private 
  #   def user_params
  #       params.require(:user).permit(:about)
  #     end
      
  #   def set_user
  #     @Session = Session.find(params[:id])
  #   end
  # end
end
