class AuthController < ApplicationController
  def callback
    auth = omniauth_params
    userExists = User.exists?(stem_user_id: auth.uid)
    user = User.from_auth(auth.uid, auth.credentials, auth.info)
    session[:user_id] = user.id

    if userExists
      flash[:notice] = 'Welcome back, good to see you again!'
      redirect_to omniauth_params['returnTo'] || dashboard_path
    else
      flash[:notice] = 'Hello and welcome to the National Centre for Computing Education'
      redirect_to omniauth_params['returnTo'] ? "#{omniauth_params['returnTo']}?firstLogin=true" : dashboard_path(firstLogin: true)
    end
  end

  def failure
    flash[:error] = "Sorry, we were unable to log you in. Please try again or contact us for help."
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to "#{ENV.fetch('STEM_OAUTH_SITE')}/user/ncce/logout"
  end

  private

  def omniauth_params
    request.env['omniauth.auth']
  end
end
