require "spec_helper"
require "dotenv"
require "simplecov"

SimpleCov.minimum_coverage ENV["SIMPLECOV_MIN_COVERAGE"].to_i
SimpleCov.start "rails" do
  require_relative "support/simplecov_warnings_patch" # To remove excess warnings from line below
  enable_coverage_for_eval

  add_group "Services", "app/services"
  add_group "Presenters", "app/presenters"
  add_group "Components", "app/components"
  add_group "Views", "app/views"

  current_branch = `git rev-parse --abbrev-ref HEAD`
  changed_files = `git diff --name-only main...#{current_branch}`.split("\n")
  add_group "Changed" do |source_file|
    changed_files.detect do |filename|
      source_file.filename.ends_with?(filename)
    end
  end
end

ENV["RAILS_ENV"] ||= "test"
Dotenv.overload(".env.test") # Ensure .env.test is used in dev environments

require File.expand_path("../config/environment", __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "webmock/rspec"
require "rspec/json_expectations"
require "capybara/rspec"
require "view_component/test_helpers"
require "view_component/system_test_helpers"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

selenium_driver = :local_chrome_headless
Capybara.server = :puma, {Silent: true}
Capybara.default_max_wait_time = 5
Capybara.register_driver selenium_driver do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument("headless=new")
  options.add_argument("--disable-dev-shm-usage") # without this you may get Selenium::WebDriver::Error::InvalidSessionError
  options.add_argument("--disable-extensions")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-gpu")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--verbose")
  options.add_argument("--enable-logging")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end
Capybara.javascript_driver = selenium_driver
Capybara.save_path = Rails.root.join("tmp", "screenshots")

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include RackAttackStubs
  config.include AchieverStubs
  config.include CurriculumStubs
  config.include StrapiStubs
  config.include Cms::Mocks
  config.include CachingHelpers
  config.include ResponsiveHelpers
  config.include ActiveSupport::Testing::TimeHelpers
  config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.include FeatureFlagHelper
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component_sys_test

  # https://github.com/ViewComponent/view_component/issues/1630 - Overrrides the Capybara overwrite
  config.before(:each, type: :component_sys_test) do
    def page
      Capybara.current_session
    end
  end

  config.before(:suite) do
    Webpacker.compile if Webpacker.instance.compiler.stale?
  end

  config.before(:each) { stub_cloudflare_ip_lookup }

  config.around(:each, type: :system) do |example|
    Rails.application.config.action_controller.allow_forgery_protection = true
    example.run
    Rails.application.config.action_controller.allow_forgery_protection = false
  end

  config.before(:each, type: :system) do
    driven_by selenium_driver
    stub_strapi_header
  end

  config.before(:each, type: :request) do
    stub_strapi_header
  end

  config.after(:each, js: true, type: :system) do |_spec|
    errors = page.driver.browser.manage.logs.get(:browser)
      .select { |e| e.level == "SEVERE" && e.message.present? }
      .map(&:message)
      .to_a

    raise JavascriptError errors.join("\n\n") if errors.present? && ENV["RAISE_CONSOLE_ERRORS"]
  end
end

Timecop.safe_mode = true
