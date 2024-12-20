// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from '@hotwired/stimulus'
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

const application = Application.start()
const context = require.context("./", true, /\.js$/)
const contextComponents = require.context("../../../components/", true, /_controller\.js$/)

const componentDefinitions = definitionsFromContext(contextComponents)
componentDefinitions.forEach(definition => {
  const identifierParts = definition.identifier.split("--")
  if(identifierParts.length == 3) {
    // To handle indentifiers in the sub folder (e.g. components/cms/**/*.js) this keeps the sub-domain
    // and removes the self-named folder
    definition.identifier = identifierParts[0] + "--" + identifierParts[2]
  }else{
    // if you create a `components/foo_component/foo_component_controller.js` the
    // default identifier will be `foo-component--foo-component`. this rewrites those
    // identifiers to just `foo-component`
    const isSelfNamed = identifierParts.every(x => x === identifierParts[0])
    if (!isSelfNamed) return

    definition.identifier = identifierParts[0]
  }
})

application.load(
  definitionsFromContext(context)
    .concat(componentDefinitions)
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
