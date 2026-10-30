import { initAll } from 'govuk-frontend'
import { onPageLoad } from 'utilities/loaders'
// initAll() does nothing unless the body has govuk-frontend-supported, which js_enabled adds.
// Importing it here registers its page load listener first, whatever order application.js uses.
import 'js_enabled'

onPageLoad(() => {
  initAll()
})
