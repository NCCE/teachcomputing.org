require 'spec_helper'
require 'simplecov'
require 'vcr'

SimpleCov.minimum_coverage 90
SimpleCov.start 'rails' do
  add_group 'Services', 'app/services'
  add_group 'Presenters', 'app/presenters'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
require 'rspec/json_expectations'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

selenium_driver = :selenium_chrome_headless
Capybara.server = :puma, { Silent: true }
Capybara.register_driver selenium_driver do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--disable-extensions')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1400,1400')
  options.add_argument('--verbose')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.javascript_driver = selenium_driver

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include AchieverStubs
  config.include CurriculumStubs
  config.include GhostStubs
  config.include CachingHelpers
  config.include ResponsiveHelpers
  config.include ActiveSupport::Testing::TimeHelpers
  config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.include FeatureFlagHelper

  config.before(:suite) do
    Webpacker.compile
  end

  config.before(:each, type: :system) do
    driven_by selenium_driver
  end
end
