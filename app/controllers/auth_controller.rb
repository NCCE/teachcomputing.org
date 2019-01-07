class AuthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.from_auth(auth.uid, auth.credentials, auth.info)
    flash[:notice] = 'Welcome to NCCE' unless UserDetail.exists?(stem_user_id: auth.uid)
    user.set_or_create_user

    session[:current_user] = user

    redirect_to omniauth_params['returnTo'] || root_path
  end

  def logout
    session[:current_user] = nil
    redirect_to root_path
  end

  private

  def omniauth_params
    request.env['omniauth.params']
  end
end