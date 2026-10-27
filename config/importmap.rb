# Pin npm packages by running ./bin/importmap

pin "application"
pin "administrate", preload: false
pin "courses"
pin "dropdown__expander"
pin "govuk_frontend_init"
pin "js_enabled"
pin "turbolinks_start", preload: false
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/administrate", under: "administrate", preload: false
pin_all_from "app/javascript/utilities", under: "utilities"

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@rails/ujs", to: "rails-ujs.esm.js"
pin "flatpickr" # @4.6.13
pin "govuk-frontend" # @5.4.0
# Not "turbolinks.js": the turbolinks gem ships a non-ESM file with that name, and Propshaft
# serves whichever is first in the asset paths (the gem's, on Heroku).
pin "turbolinks", to: "turbolinks.esm.js", preload: false # @5.2.0
