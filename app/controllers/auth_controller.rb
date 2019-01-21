class AuthController < ApplicationController
  def callback
    auth = omniauth_params
    userExists = User.exists?(stem_user_id: auth.uid)
    flash[:notice] = 'Welcome' unless userExists
    user = User.from_auth(auth.uid, auth.credentials, auth.info)
    session[:user_id] = user.id
    if userExists
      redirect_to omniauth_params['returnTo'] || dashboard_path
    else
      redirect_to omniauth_params['returnTo'] ? "#{omniauth_params['returnTo']}?firstLogin=true" : dashboard_path(firstLogin: true)
    end
  end

  def failure
    flash[:error] = 'Whoops something went wrong'
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to "#{ENV.fetch('STEM_OAUTH_SITE', 'https://www.stem.org.uk/user/logout')}/user/logout"
  end

  private

  def omniauth_params
    request.env['omniauth.auth']
  end
end
