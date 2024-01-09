Sidekiq.default_job_options = {retry: false}
Sidekiq.logger.level = Logger::WARN unless ENV["SIDEKIQ_DEBUG"] == "true"

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_URL"], size: 2, ssl_params: {verify_mode: OpenSSL::SSL::VERIFY_NONE}}
end

Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_URL"], size: 15, ssl_params: {verify_mode: OpenSSL::SSL::VERIFY_NONE}}
end
