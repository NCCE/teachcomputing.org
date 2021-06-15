import GOVUKFrontend from 'govuk-frontend/govuk/all'

const initialise = () => {
  GOVUKFrontend.initAll()
}

window.addEventListener('DOMContentLoaded', initialise)
window.addEventListener('turbolinks:render', initialise)
