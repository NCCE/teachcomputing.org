source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.6"

gem "activestorage-validator"
gem "administrate", "~> 0.20.0"
gem "administrate-field-active_storage"
gem "administrate-field-jsonb"
gem "administrate-field-nested_has_many"
gem "attr_encrypted"
gem "audited"
gem "aws-sdk-s3", require: false
gem "bootsnap", ">= 1.5.1", require: false
gem "cloudflare-rails"
gem "combine_pdf", ">= 1.0.18"
gem "connection_pool"
gem "dalli"
gem "enumerize"
gem "faraday"
gem "fog-aws"
gem "geocoder", ">= 1.6.6"
gem "graphlient"
gem "htmlentities"
gem "humanize"
gem "jwt"
gem "lograge"
gem "memcachier"
gem "mimemagic"
gem "net-imap"
gem "net-pop"
gem "net-smtp"
gem "nokogiri", "1.18.9"
gem "oauth2"
gem "omniauth"
gem "omniauth-oauth2"
gem "omniauth-auth0"
gem "omniauth-rails_csrf_protection"
gem "pagy"
gem "pg"
gem "pg_search"
gem "prawn"
gem "puma"
gem "rack-attack"
gem "rack-cors", require: "rack/cors"
gem "rails", "~> 7.1.0"
gem "rails-healthcheck"
gem "rest-client"
gem "scout_apm"
gem "sentry-rails"
gem "sentry-ruby"
gem "sentry-sidekiq"
gem "sidekiq"
gem "sitemap_generator"
gem "stackprof"
gem "statesman", "= 10.0.0" # Pinned due to bug https://github.com/gocardless/statesman/issues/509
gem "terser"
gem "turbolinks"
gem "uglifier"
gem "view_component"
gem "webpacker"
gem "wicked"
# must match the version used to generate the schema
gem "graphql"
group :development, :test do
  gem "brakeman"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem "debase"
  gem "dotenv-rails"
  gem "interception"
  gem "pry"
  gem "pry-byebug", "~> 3.11.0"
  gem "pry-rails"
  gem "pry-rescue"
  gem "rails-erd"
  gem "ruby-debug-ide"
end

# For component previews
group :staging, :test do
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"
  gem "erb_lint", require: false
  gem "listen"
  gem "rack-mini-profiler"
  gem "reek"
  gem "solargraph"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console", ">= 3.3.0"
  gem "bullet", "~> 7.1.0"
  gem "standard"
  gem "standard-rails"
end

group :test do
  gem "axe-matchers", ">= 2.5.0", require: false
  gem "capybara"
  gem "climate_control"
  gem "generator_spec"
  gem "guard-rspec", require: false
  gem "rails-controller-testing"
  gem "rspec-json_expectations"
  gem "rspec_junit_formatter"
  gem "rspec-mocks"
  gem "rspec-rails"
  gem "selenium-webdriver", "~> 3.142.7"
  gem "shoulda-callback-matchers"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "timecop"
  gem "webmock"
end
