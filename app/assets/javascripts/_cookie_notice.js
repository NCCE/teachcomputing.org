window.addEventListener('load', function () {
  window.cookieconsent.hasTransition = false
  window.cookieconsent.initialise({
    secure: true,
    showLink: false,
    autoOpen: true,

    overrideHTML:
      "<div id='global-cookie-message'><div class='cookie-inner govuk-width-container'><p class='govuk-body'>We use cookies to make the site simpler. <a class='ncce-link ncce-link--on-dark' href='/privacy'>Learn more</a></p> <a class='cc-btn cc-dismiss ncce-link ncce-link--on-dark govuk-!-margin-left-2' href=''>OK</a></div></div>",
    position: 'top',
  })
})
