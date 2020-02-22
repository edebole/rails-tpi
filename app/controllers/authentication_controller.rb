class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login
  before_action :set_user, only: :login

  # POST /sesiones
  def login
    if @user && @user.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = time = Time.now + 30.minutes.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
    else
      render json: { errors: { message: 'unauthorized' }}, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find_by(username: login_params[:username])	  
  end

  def login_params
    params.require(:authentication).permit(:username, :password)
  end
end

