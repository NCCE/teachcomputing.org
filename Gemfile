source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'activestorage-validator'
gem 'administrate', '~> 0.16.0'
gem 'attr_encrypted', '~> 3.1.0'
gem 'awesome_print'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.5.1', require: false
gem 'cloudflare-rails', '~> 1.1'
gem 'combine_pdf', '~> 1.0', '>= 1.0.18'
gem 'connection_pool', '~> 2.2.2'
gem 'dalli', '~> 2.7.9'
gem 'faraday', '~> 1.0', require: false
gem 'fog-aws', '~> 3.3'
gem 'geocoder', '~> 1.6', '>= 1.6.6'
gem 'graphlient', '~> 0.4'
gem 'htmlentities', '~> 4.3'
gem 'ims-lti', '1.2.4'
gem 'jwt', '~> 2.1.0'
gem 'kramdown', '>= 2.3.1'
gem 'lograge'
gem 'memcachier'
gem 'mimemagic', '~> 0.3.7'
gem 'nokogiri', '~> 1.11.0'
gem 'oauth2', '~> 1.4.4'
gem 'omniauth', '~> 1.9.1'
gem 'omniauth-oauth2', '~> 1.6.0'
gem 'omniauth-rails_csrf_protection', '~> 0.1.2'
gem 'pg', '~> 1.1'
gem 'prawn', '~> 2.3'
gem 'pretender', '~> 0.3.4'
gem 'puma', '~> 4.3'
gem 'rack-attack', '~> 5.4.2'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.1.3.2'
gem 'redis-rails', '~> 5.0.2'
gem 'rest-client', '~> 2.0.2'
gem 'rspec_junit_formatter', '~> 0.4.1'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'sidekiq', '~> 5.2.5'
gem 'sitemap_generator', '~> 6.0.2'
gem 'statesman', '~> 4.1.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 4.2'
gem 'view_component', require: 'view_component/engine'
gem 'webpacker', '~> 5.4.0'
gem 'wicked', '~> 1.3.4'
# must match the version used to generate the schema
gem 'graphql', '<= 1.10.10'

group :development, :test do
  gem 'brakeman'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'debase', '~> 0.2.4'
  gem 'dotenv-rails'
  gem 'erb_lint', require: false
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'interception'
  gem 'pry'
  gem 'pry-byebug', '~> 3.9.0'
  gem 'pry-rescue'
  gem 'reek'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop'
  gem 'rubocop-changes'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'ruby-debug-ide'
  gem 'solargraph'
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rack-mini-profiler', '~> 2.3.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'axe-matchers', '>= 2.5.0', require: false
  gem 'capybara', '~> 3.32'
  gem 'rails-controller-testing'
  gem 'rspec-json_expectations'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov'
  gem 'vcr'
end

gem 'tzinfo-data'
