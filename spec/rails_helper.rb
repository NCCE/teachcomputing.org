require 'spec_helper'
require 'vcr'
require 'dotenv'
require 'simplecov'

# SimpleCov.minimum_coverage ENV['SIMPLECOV_MIN_COVERAGE'].to_i
# SimpleCov.start 'rails' do
#   add_group 'Services', 'app/services'
#   add_group 'Presenters', 'app/presenters'

#   current_branch = `git rev-parse --abbrev-ref HEAD`
#   changed_files = `git diff --name-only main...#{current_branch}`.split("\n")
#   add_group 'Changed' do |source_file|
#     changed_files.detect do |filename|
#       source_file.filename.ends_with?(filename)
#     end
#   end
# end

ENV['RAILS_ENV'] ||= 'test'
Dotenv.overload('.env.test') # Ensure .env.test is used in dev environments

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
require 'rspec/json_expectations'
require 'capybara/rspec'
require 'view_component/test_helpers'
require 'capybara/cuprite'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, browser_options: { 'no-sandbox': nil })
end

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end

VCR.turn_off! # Only turn on as and when needed

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include AchieverStubs
  config.include CredlyStubs
  config.include CurriculumStubs
  config.include GhostStubs
  config.include CachingHelpers
  config.include ResponsiveHelpers
  config.include ActiveSupport::Testing::TimeHelpers
  config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.include FeatureFlagHelper
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component

  config.before(:suite) do
    Webpacker.compile if Webpacker.instance.compiler.stale?
  end

  config.before(:each, type: :system) do
    driven_by :cuprite
  end
end
