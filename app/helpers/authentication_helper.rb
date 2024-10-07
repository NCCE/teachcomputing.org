module AuthenticationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def profile_edit_url
    "#{Rails.application.config.stem_account_domain}/edit-profile"
  end
end
