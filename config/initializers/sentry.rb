Sentry.init do |config|
  config.dsn = Rails.application.credentials[ENV.fetch('SENTRY_DSN')]
  config.rails.report_rescued_exceptions = true
  config.breadcrumbs_logger = [:active_support_logger]
  config.traces_sample_rate = 0.5
  config.enabled_environments = %w[staging]

  filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  config.before_send = lambda do |event, _hint|
    request = event.request

    request.data = filter.filter(request.data) if request

    event
  end
end
