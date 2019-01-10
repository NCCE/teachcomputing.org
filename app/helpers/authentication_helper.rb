module AuthenticationHelper
  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end
end
