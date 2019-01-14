Raven.configure do |config|
  config.dsn = Rails.application.credentials[ENV.fetch('SENTRY_DSN')]
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
