require_relative "boot"

require "logger"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TeachComputing
  class Application < Rails::Application
    config.action_dispatch.cookies_same_site_protection = :lax

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.active_support.cache_format_version = 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks generators])

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.exceptions_app = routes

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    config.view_component.default_preview_layout = "view_component_preview"

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**/*.{rb,yml}").to_s]

    config.mylearning_dashboard_url = ENV["MYLEARNING_DASHBOARD_URL"]

    config.static_asset_url = ENV["STATIC_FILE_PATH"]

    # CMS settings
    config.cms_provider = ENV["CMS_PROVIDER"]
    config.strapi_api_key = ENV["STRAPI_API_KEY"]
    config.strapi_api_url = ENV["STRAPI_API_URL"]
    config.strapi_graphql_url = ENV["STRAPI_GRAPHQL_URL"]
    config.strapi_write_api_key = ENV["STRAPI_WRITE_API_KEY"]
    config.strapi_connection_type = ENV["STRAPI_CONNECTION_TYPE"]

    # Credly settings
    config.credly_url = ENV["CREDLY_URL"]
    config.credly_auth_token = ENV["CREDLY_AUTH_TOKEN"]
    config.credly_org_id = ENV["CREDLY_ORGANISATION_ID"]

    # Auth Settings
    config.bypass_oauth = ENV["BYPASS_OAUTH"] == "true"
    config.stem_account_site = ENV["STEM_ACCOUNT_SITE"]
    config.stem_credentials_access_token = ENV["STEM_CREDENTIALS_ACCESS_TOKEN_KEY"]
    config.stem_credentials_refresh_token = ENV["STEM_CREDENTIALS_REFRESH_TOKEN_KEY"]

    config.stem_course_redirect = ENV["STEM_CPD_STORE_REDIRECT"]

    # default is true
    config.secure_cookies = ENV["SECURE_COOKIES"] != "off"
  end
end
