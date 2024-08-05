import { Application } from '@hotwired/stimulus'
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"


const application = Application.start()

const context = require.context("./", true, /\.js$/)
const contextComponents = require.context("../../../views/fields", true, /_controller\.js$/)
application.load(
  definitionsFromContext(contextComponents)
)
