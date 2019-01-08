module AuthenticationHelper
  def current_user
    @current_user = if session[:user_id]
                      User.find_by(id: session[:user_id])
                    else
                      User.from_session(session[:user_id])
                    end
  end
end
