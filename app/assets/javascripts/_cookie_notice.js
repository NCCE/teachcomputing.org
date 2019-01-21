window.addEventListener('load', function() {
    window.cookieconsent.hasTransition = false
    window.cookieconsent.initialise({
      showLink: false,
      autoOpen: true,
      overrideHTML:
        "<div id='global-cookie-message'><div class='cookie-inner'><p class='govuk-body'>We use cookies to make the site simpler. <a class='govuk-link ncce-link__on-light' href='/privacy'>Learn more</a></p> <a class='cc-btn cc-dismiss govuk-link ncce-link__on-light' href=''>OK</a></div></div>",
      position: 'top',
    })
  })
