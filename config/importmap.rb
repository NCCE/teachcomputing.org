# Pin npm packages by running ./bin/importmap

# preload: "application" / "administrate" limits a module preload to the layout using that entry point,
# so admin pages don't download the public site's JS (and vice versa).
pin "application", preload: "application"
pin "administrate", preload: "administrate"
pin "courses", preload: "application"
pin "disable_with", preload: "application"
pin "dropdown__expander", preload: "application"
pin "govuk_frontend_init", preload: "application"
pin "js_enabled", preload: "application"
pin_all_from "app/javascript/controllers", under: "controllers", preload: "application"
pin_all_from "app/javascript/administrate", under: "administrate", preload: "administrate"
pin_all_from "app/javascript/utilities", under: "utilities", preload: "application"

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "flatpickr", preload: "application" # @4.6.13
# Copied by hand from node_modules (see the file's header), so it has no "# @version" comment:
# with one, bin/importmap pristine/update would replace it with jspm's broken stub.
pin "govuk-frontend", preload: "application"
