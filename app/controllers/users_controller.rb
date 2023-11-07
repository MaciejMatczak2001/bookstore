class UsersController < ApplicationController
  include Authorizable
  before_action :set_user, only: %i[block destroy unblock]
  before_action :check_admin_privilages, only: %i[index destroy block unblock]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.create(user_params)
	  if @user.save
	    session[:user_id] = @user.id
	    redirect_to root_path, notice: "Account created"
	  else
	    redirect_to sign_up_path, alert: "Could not create the account"
	  end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User deleted"
  end

  def block
    @user.update_attribute(:blocked, true)
    redirect_to users_path, notice: "User #{@user.email} was blocked"
  end

  def unblock
    @user.update_attribute(:blocked, false)
    redirect_to users_path, notice: "User #{@user.email} was unblocked"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :password)
  end

end
