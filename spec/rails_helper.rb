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

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

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
    FileUtils.mkdir_p(path)

    path
  end
end

VCR.configure do |config|
<<<<<<< HEAD
  config.default_cassette_options = { :record => :once }
  config.cassette_library_dir = "#{::Rails.root}/spec/vcr"
=======
  config.default_cassette_options = { :record => :new_episodes }
  config.cassette_library_dir = "spec/vcr"
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
  config.hook_into :webmock
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
  config.include ActiveSupport::Testing::TimeHelpers

  VCR.turn_off! # Turn it on selectively

  config.before(:each, type: :system) do
    if ENV['ENV_TYPE'] == 'development'
      driven_by :local_chrome_headless
    else
      driven_by :selenium_chrome_headless
    end
  end
end
