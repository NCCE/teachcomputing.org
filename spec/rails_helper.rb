require "spec_helper"
require "dotenv"
require "simplecov"

SimpleCov.minimum_coverage ENV["SIMPLECOV_MIN_COVERAGE"].to_i

SimpleCov.singleton_class.prepend(Module.new do
  def exit_status_from_exception
    err = $ERROR_INFO
    if err
      status = err.is_a?(SystemExit) ? err.status : "N/A"
      warn "[SC Debug] $! = #{err.class} (status=#{status}): #{err.message}"
      warn "[SC Debug] backtrace: #{err.backtrace&.first(3)&.join(" | ")}"
    else
      warn "[SC Debug] $! is nil (clean exit)"
    end
    super
  end

  # Capybara's at_exit calls `exit @exit_status` to preserve the test suite exit code,
  # which SimpleCov sees as a "previous error" and short-circuits without processing
  # coverage. This override always runs coverage and exits with the max of both statuses.
  def run_exit_tasks!
    error_exit_status = exit_status_from_exception
    at_exit.call

    coverage_exit_status = 0
    if ready_to_process_results?
      coverage_exit_status = process_result(result)
      if coverage_exit_status.positive? && print_error_status
        warn("SimpleCov failed with exit #{coverage_exit_status} due to a coverage related error")
      end
    end

    final_exit_status = [error_exit_status.to_i, coverage_exit_status].max
    Kernel.exit(final_exit_status) if final_exit_status.positive?
  end
end)

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

RSpec::Core::Runner.prepend(Module.new do
  def exit_code(examples_passed = false)
    result = super
    warn "[Runner Debug] exit_code: examples_passed=#{examples_passed}, non_example_failure=#{@world.non_example_failure}, result=#{result}"
    result
  end
end)

RSpec::Core::Reporter.prepend(Module.new do
  def finish
    warn "[Reporter Debug] finish() starting, scope=#{RSpec.current_scope}"
    super
    warn "[Reporter Debug] finish() completed"
  rescue => e
    warn "[Reporter Debug] finish() raised #{e.class}: #{e.message}"
    raise
  end
end)

TracePoint.new(:raise) do |tp|
  ex = tp.raised_exception
  next unless ex.is_a?(SystemExit) && ex.status != 0

  scope = RSpec.respond_to?(:current_scope) ? RSpec.current_scope : :unknown
  warn "[Exit Trace] SystemExit(#{ex.status}) at #{tp.path}:#{tp.lineno}, scope=#{scope}"
  warn "[Exit Trace] caller: #{caller.first(8).join(" | ")}"
end.enable

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

  options.add_argument("--headless=new")
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
  rescue => e
    warn "Webpacker setup error (non-fatal): #{e.message}"
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
    stub_strapi_footer
    stub_strapi_site_wide_banner
  end

  config.before(:each, type: :request) do
    stub_strapi_header
    stub_strapi_footer
    stub_strapi_site_wide_banner
  end

  config.after(:each, js: true, type: :system) do |_spec|
    errors = page.driver.browser.logs.get(:browser)
      .select { |e| e.level == "SEVERE" && e.message.present? }
      .map(&:message)
      .to_a

    raise JavascriptError errors.join("\n\n") if errors.present? && ENV["RAISE_CONSOLE_ERRORS"]
  end
end

Timecop.safe_mode = true
