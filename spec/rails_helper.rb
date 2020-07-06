require 'spec_helper'
require 'simplecov'

SimpleCov.start 'rails' do
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'capybara/rspec'
Capybara.server = :puma, { Silent: true }
Capybara.default_driver = :selenium

# This is necessary to get chrome to run headless in the container
Capybara.register_driver :local_chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :local_chrome_headless

WebMock.disable_net_connect!(allow_localhost: true, allow: /chromedriver/)

module CachingHelpers
  def file_caching_path
    path = "tmp/test#{ENV['TEST_ENV_NUMBER']}/cache"
    FileUtils::mkdir_p(path)

    path
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include AchieverStubs
  config.include CurriculumStubs
  config.include GhostStubs
  config.include CachingHelpers

  config.before(:each, type: :system) do
    if ENV['ENV_TYPE'] == 'development'
      driven_by :local_chrome_headless
    else
      driven_by :selenium_chrome_headless
    end
  end
end
