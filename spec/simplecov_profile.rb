# Shared by rails_helper (when running specs) and the CI coverage job (when collating each parallel node's results),
# so the combined report uses the same filters and groups as a local run
SimpleCov.profiles.define "teachcomputing" do
  load_profile "rails"

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
      source_file.filename.end_with?(filename) # Not ends_with?, as Rails isn't loaded when collating
    end
  end
end
