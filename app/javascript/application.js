import { Turbo } from '@hotwired/turbo-rails'

import 'controllers'
import 'courses'
import 'disable_with'
import 'dropdown__expander'
import 'govuk_frontend_init'
import 'js_enabled'

// Public pages do full page loads; Drive would mean re-initialising every page's JS on turbo:load.
// Turbo still handles data-turbo-confirm and anything opted in with data-turbo="true".
Turbo.session.drive = false
