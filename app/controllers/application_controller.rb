class ApplicationController < ActionController::Base
  include AuthenticationHelper
  include HttpHeaders
  include Pagy::Backend

  before_action :authenticate
  before_action :access_cms_header
  before_action :access_cms_footer
  before_action :access_cms_site_wide_notification

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

  def access_cms_site_wide_notification
    @cms_site_wide_banner = Cms::Collections::SiteWideBanner.all_records

    current_time = Time.now.utc

    active_banners = @cms_site_wide_banner.select do |banner|
      start_time = Time.parse(banner.start_time.value)
      end_time = Time.parse(banner.end_time.value)

      current_time >= start_time && current_time <= end_time
    end

    @current_notification = active_banners.first
  end

  def authenticate_user!
    redirect_to(helpers.create_account_url) unless current_user
  end

  def redirect_to_dashboard
    redirect_to dashboard_path if current_user
  end
end
