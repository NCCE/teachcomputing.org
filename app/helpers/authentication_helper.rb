module AuthenticationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def profile_edit_url
    URI::HTTPS.build(host: Rails.application.config.stem_account_site, path: "/edit-profile").to_s
  end
end
