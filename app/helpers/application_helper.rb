module ApplicationHelper
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    return unless !!session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
