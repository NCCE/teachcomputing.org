Sidekiq.default_worker_options = { retry: false }
Sidekiq::Logging.logger.level = Logger::WARN

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], size: 2, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], size: 15, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end
