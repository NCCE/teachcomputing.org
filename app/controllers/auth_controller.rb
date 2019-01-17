class AuthController < ApplicationController
  def callback
    auth = omniauth_params
    flash[:notice] = 'Welcome' unless User.exists?(stem_user_id: auth.uid)
    user = User.from_auth(auth.uid, auth.credentials, auth.info)

    session[:user_id] = user.id
    redirect_to omniauth_params['returnTo'] || dashboard_path
  end

  def failure
    flash[:alert] = 'Whoops something went wrong'
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private

  def omniauth_params
    request.env['omniauth.auth']
  end
end
