require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = Uglifier.new(harmony: true)
  config.assets.css_compressor = nil
  config.sass.style = :compressed
  config.sass.line_comments = false

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :amazon

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [
    :request_id,
    lambda do |request|
      session_key = (Rails.application.config.session_options || {})[:key]
      session_data = request.cookie_jar.encrypted[session_key] || {}
      user_id = session_data["user_id"] || "guest"
      session_id = session_data["session_id"] || "no-session"
      "session: #{session_id}, user: #{user_id}, user_agent: #{request.user_agent}"
    end
  ]

  # Use a different cache store in production.
  config.cache_store = :mem_cache_store,
    (ENV["MEMCACHEDCLOUD_SERVERS"] || "").split(","),
    {username: ENV["MEMCACHEDCLOUD_USERNAME"],
     password: ENV["MEMCACHEDCLOUD_PASSWORD"],
     failover: true,
     socket_timeout: 1.5,
     socket_failure_delay: 0.2,
     down_retry_delay: 60,
     pool_size: 5,
     value_max_bytes: 10485760,
     ssl_params: {verify_mode: OpenSSL::SSL::VERIFY_NONE}}

  # Use a real queuing backend for Active Job (and separate queues per environment)
  config.active_job.queue_adapter = :sidekiq
  # config.active_job.queue_name_prefix = "project_#{Rails.env}"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.asset_host = "https://teachcomputing.org"
  config.action_mailer.default_url_options = {host: "https://teachcomputing.org"}
  config.action_mailer.smtp_settings = {
    address: "smtp.mandrillapp.com",
    port: 587,
    enable_starttls_auto: true,
    user_name: ENV.fetch("MANDRILL_SMTP_USERNAME"),
    password: ENV.fetch("MANDRILL_API_KEY"),
    authentication: :plain,
    domain: "teachcomputing.org"
  }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.report_deprecations = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new($stdout)
    .tap { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Enable lograge to make logs less verbose
  config.lograge.enabled = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.middleware.use Rack::Attack

  # Enable secure cookies (will only work on https)
  config.session_store :cookie_store,
    key: "_teach_computing_session",
    secure: true,
    httponly: true,
    expire_after: 48.hours

  config.hosts = [
    "teachcomputing.org",
    ".teachcomputing.org"
  ]
end
