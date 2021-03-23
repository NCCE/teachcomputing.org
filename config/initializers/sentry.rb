Sentry.init do |config|
  config.dsn = Rails.application.credentials[ENV.fetch('SENTRY_DSN')]
  config.rails.report_rescued_exceptions = true
end
