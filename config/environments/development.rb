Rails.application.configure do
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # deliver to mailhog (`brew install mailhog` and visit http://localhost:8025 to see mails)
  config.action_mailer.smtp_settings = {
    address: "host.docker.internal",
    port: 1025
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.action_mailer.preview_path = "#{Rails.root}/previews/mailers"
  config.action_mailer.asset_host = "http://localhost:3000"
  config.action_mailer.default_url_options = {host: "http://localhost:3000"}

  # Raises error for missing translations
  config.i18n.raise_on_missing_translations = true

  config.web_console.whiny_requests = false
  config.web_console.permissions = "0.0.0.0/0"

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Ensure every change triggers an update (in development only), else docker misses things.
  config.file_watcher = ActiveSupport::FileUpdateChecker

  # Allow nicer hostname
  config.hosts << /([a-z0-9.])+\.rpfdev\.com/
  config.hosts << "web"
  config.hosts << "teachcomputing.test"
  config.autoload_paths << "lib"

  config.view_component.preview_paths << "#{Rails.root}/previews/components"
  config.view_component.preview_route = "/rails/components"

  config.lograge.enabled = true
  config.lograge.ignore_actions = [Healthcheck::CONTROLLER_ACTION]
  config.lograge.custom_options = lambda do |event|
    {
      exception: event.payload[:exception], # ["ExceptionClass", "the message"]
      exception_object: event.payload[:exception_object] # the exception instance
    }
  end

  config.active_job.queue_adapter = :sidekiq

  config.strapi_image_url = ENV["STRAPI_IMAGE_URL"]
end
