class AuthController < ApplicationController
  before_action :set_raven_context, only: :callback

  def callback
    auth = omniauth_params
    course_booking_uri = request.env['omniauth.params']['source_uri']
    user_exists = User.exists?(stem_user_id: auth.uid)
    user = User.from_auth(auth.uid, auth.credentials, auth.info)
    session[:user_id] = user.id

    puts "course_booking_uri #{course_booking_uri} user_exists #{user_exists} (request.env['omniauth.params'] #{request.env['omniauth.params']})"
    if user_exists
      flash[:notice] = 'Welcome back, good to see you again!'
      redirect_to course_booking_uri || dashboard_path
    else
      flash[:notice] = 'Hello and welcome to the National Centre for Computing Education'
      redirect_to course_booking_uri ? "#{course_booking_uri}?firstLogin=true" : dashboard_path(firstLogin: true)
    end
  end

  def failure
    flash[:error] = 'Sorry, we were unable to log you in. Please try again or contact us for help.'
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

  def set_raven_context
    auth = omniauth_params
    Raven.extra_context(
      id: auth.uid,
      info: auth.info
    )
  end
end
