// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context("./", true, /\.js$/)
const contextComponents = require.context("../../../components", true, /_controller\.js$/)
application.load(
  definitionsFromContext(context).concat(
    definitionsFromContext(contextComponents)
  )
)

// Support defining methods to be called on pageshow and pagehide events
window.addEventListener('pageshow', event => {
  application.controllers.forEach(controller => {
    if (typeof controller.pageShow === 'function') {
      controller.pageShow(event.persisted)
    }
  })
})
window.addEventListener('pagehide', () => {
  application.controllers.forEach(controller => {
    if (typeof controller.pageHide === 'function') {
      controller.pageHide()
    }
  })
})
