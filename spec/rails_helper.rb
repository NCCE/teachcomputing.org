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
Capybara.default_driver = :selenium_chrome_headless


WebMock.disable_net_connect!(allow_localhost: true, allow: /chromedriver/)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include AchieverStubs

  config.include GhostStubs

  config.before(:each, type: :system) do
    if ENV["SELENIUM_DRIVER_URL"].present?
      driven_by :selenium, using: :chrome,
                           options: {
                               browser: :remote,
                               url: ENV.fetch("SELENIUM_DRIVER_URL"),
                               desired_capabilities: :chrome}
    else
      driven_by :selenium_chrome_headless
    end
  end
end
