class ApplicationController < ActionController::Base
  include AuthenticationHelper
  include HttpHeaders
  include Pagy::Backend

  before_action :authenticate
  before_action :access_cms_header
  before_action :access_cms_footer

  def authenticate
    return unless ENV["BASIC_AUTH_PASSWORD"]

    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def access_cms_header
    @cms_header = Cms::Singles::Header.get
  rescue ActiveRecord::RecordNotFound
    @cms_header = nil
  end

  def access_cms_footer
    @cms_footer = Cms::Singles::Footer.get
  rescue ActiveRecord::RecordNotFound
    @cms_footer = nil
  end

  def authenticate_user!
    redirect_to(helpers.create_account_url) unless current_user
  end

  def redirect_to_dashboard
    redirect_to dashboard_path if current_user
  end
end
