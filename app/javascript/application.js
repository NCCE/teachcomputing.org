import { Turbo } from '@hotwired/turbo-rails'

import 'controllers'
import 'courses'
import 'disable_with'
import 'dropdown__expander'
import 'govuk_frontend_init'
import 'js_enabled'

// Public pages do full page loads; Drive would mean re-initialising every page's JS on turbo:load.
// With Drive off, Turbo ignores links and forms (including data-turbo-confirm/-method) unless they
// opt in with data-turbo="true".
Turbo.session.drive = false
