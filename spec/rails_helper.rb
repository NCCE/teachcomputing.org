require "spec_helper"
require "dotenv"
require "simplecov"

SimpleCov.minimum_coverage ENV["SIMPLECOV_MIN_COVERAGE"].to_i
SimpleCov.start "rails" do
  add_group "Services", "app/services"
  add_group "Presenters", "app/presenters"
  add_group "Components", "app/components"

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

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

selenium_driver = :local_chrome_headless
Capybara.server = :puma, {Silent: true}
Capybara.default_max_wait_time = 5
Capybara.register_driver selenium_driver do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--headless")
  options.add_argument("--disable-extensions")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-gpu")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--verbose")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end
Capybara.javascript_driver = selenium_driver

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include AchieverStubs
  config.include CredlyStubs
  config.include CurriculumStubs
  config.include GhostStubs
  config.include StrapiStubs
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
    driven_by selenium_driver
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
