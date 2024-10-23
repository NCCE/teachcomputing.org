class AuthController < ApplicationController
  def callback
    auth = omniauth_params
    course_booking_uri = course_redirect_params
    user_exists = User.exists?(stem_user_id: auth.info.stem_user_id)
    Rails.logger.info("Auth data #{auth}")
    user = User.from_auth(auth.uid, auth.credentials, auth.info)

    session[:user_id] = user.id

    if user_exists
      flash[:notice] = "Welcome back, good to see you again!"
      redirect_to course_booking_uri || dashboard_path
    else
      flash[:notice] = "Hello and welcome to the National Centre for Computing Education"
      redirect_to course_booking_uri ? "#{course_booking_uri}?firstLogin=true" : dashboard_path(firstLogin: true)
    end

    Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_later(user)
  rescue => e
    puts e
    Sentry.capture_exception(e)

    raise e
  end

  def failure
    Sentry.capture_message(
      "Auth failure",
      extra: {error: request.env["omniauth.error"], error_type: request.env["omniauth.error.type"]}
    )
    flash[:error] = "Sorry, we were unable to log you in. Please try again or contact us for help."
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  private

  def logout_url
    request_params = {
      returnTo: root_url
    }
    request_params[:client_id] = Rails.application.config.auth0_client_id if Rails.application.config.logout_send_client

    URI::HTTPS.build(host: Rails.application.config.logout_domain, path: Rails.application.config.logout_path, query: request_params.to_query).to_s
  end

  def omniauth_params
    request.env["omniauth.auth"]
  end

  def course_redirect_params
    helpers.safe_redirect_url(request.env["omniauth.params"]["source_uri"] || request.env["omniauth.origin"])
  end
end
