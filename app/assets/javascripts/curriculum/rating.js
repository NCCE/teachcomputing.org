AJAX_LISTENERS = { rate: 'rate' }

document.addEventListener('ajax:success', ({ detail }) => {
  const { origin, message, response } = detail[0];
  if (origin !== AJAX_LISTENERS.rate) return;
  const div = document.getElementsByClassName('curriculum__rating')[0];
  div.innerHTML = `<p class="govuk-body curriculum__rating--full_text">${message}</p>`;
});
