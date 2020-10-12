class AuthController < ApplicationController

  impersonates :user if ENV['ENABLE_IMPERSONATION']

  def callback
    auth = omniauth_params
    course_booking_uri = course_redirect_params
    user_exists = User.exists?(stem_user_id: auth.uid)
    user = User.from_auth(auth.uid, auth.credentials, auth.info)

    session[:user_id] = user.id

    if ENV['ENABLE_IMPERSONATION'] == 'true'
      impersonate_user(User.find(ENV['USER_TO_IMPERSONATE']))
      session[:user_id] = current_user.id
    end

    if user_exists
      flash[:notice] = 'Welcome back, good to see you again!'
      redirect_to course_booking_uri || welcome_path
    else
      flash[:notice] = 'Hello and welcome to the National Centre for Computing Education'
      redirect_to course_booking_uri ? "#{course_booking_uri}?firstLogin=true" : welcome_path(firstLogin: true)
    end
  end

  def failure
    flash[:error] = 'Sorry, we were unable to log you in. Please try again or contact us for help.'
    redirect_to root_path
  end

  def logout
    stop_impersonating_user if ENV['ENABLE_IMPERSONATION'] == 'true'
    reset_session
    redirect_to "#{ENV.fetch('STEM_OAUTH_SITE')}/user/ncce/logout"
  end

  private

  def omniauth_params
    request.env['omniauth.auth']
  end

  def course_redirect_params
    helpers.safe_redirect_url(request.env['omniauth.params']['source_uri'] || request.env['omniauth.origin'])
  end
end
