const setJsEnabled = () => {
  document.body.classList.add('js-enabled');
};

window.addEventListener('DOMContentLoaded', setJsEnabled);
window.addEventListener('ajax:success', setJsEnabled);
window.addEventListener('turbolinks:render', setJsEnabled);
