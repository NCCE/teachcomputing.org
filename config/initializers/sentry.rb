Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN')
  config.breadcrumbs_logger = %i[sentry_logger active_support_logger http_logger]
  config.traces_sample_rate = 0.25
  config.enabled_environments = %w[staging production]
  config.environment = ENV.fetch('HEROKU_APP_NAME') || Rails.env

  filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  config.before_send = lambda do |event, _hint|
    filter.filter(event.to_hash)
  end
end
