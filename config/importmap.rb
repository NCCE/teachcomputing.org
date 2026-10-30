# Pin npm packages by running ./bin/importmap

# preload: "application" / "administrate" limits a module preload to the layout using that entry point,
# so admin pages don't download the public site's JS (and vice versa).
pin "application", preload: "application"
pin "administrate", preload: "administrate"
pin "courses", preload: "application"
pin "dropdown__expander", preload: "application"
pin "govuk_frontend_init", preload: "application"
pin "js_enabled", preload: "application"
pin "turbolinks_start", preload: false
pin_all_from "app/javascript/controllers", under: "controllers", preload: "application"
pin_all_from "app/javascript/administrate", under: "administrate", preload: "administrate"
pin_all_from "app/javascript/utilities", under: "utilities", preload: "application"

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@rails/ujs", to: "rails-ujs.esm.js"
pin "flatpickr", preload: "application" # @4.6.13
# Copied by hand from node_modules (see the file's header), so it has no "# @version" comment:
# with one, bin/importmap pristine/update would replace it with jspm's broken stub.
pin "govuk-frontend", preload: "application"
# Not "turbolinks.js": the turbolinks gem ships a non-ESM file with that name, and Propshaft
# serves whichever is first in the asset paths (the gem's, on Heroku).
pin "turbolinks", to: "turbolinks.esm.js", preload: false # @5.2.0
