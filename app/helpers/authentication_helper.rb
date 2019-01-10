module AuthenticationHelper
  def current_user
    User.from_session(session[:user_id])
  end
end
