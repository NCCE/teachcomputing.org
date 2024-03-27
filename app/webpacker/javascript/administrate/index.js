import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()

const context = require.context("./", true, /\.js$/)
const contextComponents = require.context("../../../views/fields", true, /_controller\.js$/)
application.load(
  definitionsFromContext(contextComponents)
)
