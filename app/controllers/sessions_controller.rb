class SessionsController < ApplicationController

	skip_before_action :verify_authenticity_token

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      if @user.blocked?
        redirect_to login_path, alert: "You are blocked, please contact support"
      else
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Welcome! Login Successful"
      end
    else
      redirect_to login_path, alert: "Login failed"
    end
  end

	def destroy
		session.delete(:user_id)
		redirect_to root_path, notice: "Logged out"
	end
end
