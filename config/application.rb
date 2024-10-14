require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TeachComputing
  class Application < Rails::Application
    config.action_dispatch.cookies_same_site_protection = :lax

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.exceptions_app = routes

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**/*.{rb,yml}").to_s]

    config.mylearning_dashboard_url = ENV["MYLEARNING_DASHBOARD_URL"]

    config.cms_provider = ENV["CMS_PROVIDER"]
    config.strapi_api_key = ENV["STRAPI_API_KEY"]
    config.strapi_api_url = ENV["STRAPI_API_URL"]
    config.strapi_write_api_key = ENV["STRAPI_WRITE_API_KEY"]
    config.ghost_endpoint = ENV["GHOST_API_ENDPOINT"]
    config.ghost_api_key = ENV["GHOST_CONTENT_API_KEY"]
    config.credly_url = ENV["CREDLY_URL"]
    config.credly_auth_token = ENV["CREDLY_AUTH_TOKEN"]
    config.credly_org_id = ENV["CREDLY_ORGANISATION_ID"]
    config.stem_account_domain = ENV["STEM_ACCOUNT_DOMAIN"]
    config.stem_course_redirect = ENV["STEM_COURSE_REDIRECT"]

    # default is true
    config.secure_cookies = ENV["SECURE_COOKIES"] != "off"
  end
end
