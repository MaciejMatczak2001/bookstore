module Available
  extend ActiveSupport::Concern
    
  #checks if user is an admin, if not it responses with 401 status
  def admin_content
    unless logged_in? && current_user.role == "admin"
      render :file => "public/404.html", :status => :unauthorized
    end
  end  

  #checks if user is logged in, if not it responses with 401 status
  def logged_in_content  
	  unless logged_in?
	    render :file => "public/404.html", :status => :unauthorized
	  end
  end

  #returns current user if he is logged in
  def current_user
   	return unless logged_in?
   	@current_user ||= User.find_by_id(session[:user_id])
  end

  #checks if user is logged in
  def logged_in?
   	!!session[:user_id]
  end

end