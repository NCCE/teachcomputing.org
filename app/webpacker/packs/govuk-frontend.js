import GOVUKFrontend from 'govuk-frontend/all'

const initialise = () => {
  GOVUKFrontend.initAll();
};

window.addEventListener('DOMContentLoaded', initialise);
window.addEventListener('turbolinks:render', initialise);
