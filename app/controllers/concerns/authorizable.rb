module Authorizable
  extend ActiveSupport::Concern
    
  # checks if user is an admin, if not it responses with 401 status
  def check_admin_privilages
    unless logged_in? && current_user.admin?
      render :file => "public/401.html", :status => :unauthorized
    end
  end  

  # checks if user is logged in, if not it responses with 401 status
  def check_if_logged_in
    unless logged_in?
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  # returns current user if he is logged in
  def current_user
    return unless logged_in?
   	@current_user ||= User.find_by(id: session[:user_id])
  end

  # checks if user is logged in
  def logged_in?
   	session.present?
  end

end