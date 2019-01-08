class AuthController < ApplicationController
  def callback
    auth = omniauth_params
    flash[:notice] = 'Welcome' unless User.exists?(stem_user_id: auth.uid)
    user = User.from_auth(auth.uid, auth.credentials, auth.info)

    session[:user_id] = user.id
    redirect_to omniauth_params['returnTo'] || root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def omniauth_params
    request.env['omniauth.auth']
  end
end