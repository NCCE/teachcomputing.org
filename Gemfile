source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'attr_encrypted', '~> 3.1.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cloudflare-rails', '~> 0.4.0'
gem 'htmlentities', '~> 4.3'
gem 'nokogiri', '~> 1.8'
gem 'oauth2', '~> 1.4.1'
gem 'omniauth', '~> 1.8.1'
gem 'omniauth-oauth2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 3.11'
gem 'rack-attack', '~> 5.4.2'
gem 'rails', '~> 5.2.1'
gem 'rest-client', '~> 2.0.2'
gem 'sass-rails', '~> 5.0'
gem 'sentry-raven', '~> 2.7.4'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'guard-rspec', '~> 4.7.3', :require => false
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 3.8'
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
