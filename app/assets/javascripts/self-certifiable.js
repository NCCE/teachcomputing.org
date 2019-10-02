function initialiseselfActivity() {
  const activity = document.querySelector(
    '.ihavedonethis-links--add')
  if (!activity) {
    return
  }
  const button = activity.querySelector('button')
  const target = activity.nextElementSibling

  const wrapper = document.querySelector(
    '.ihavedonethis-links')
  wrapper.classList.toggle('ihavedonethis-links--progressive')

  target.classList.toggle('ihavedonethis--progressive')

  const listener = function () {
    const expanded = button.getAttribute('aria-expanded') === 'true'
    button.setAttribute('aria-expanded', !expanded)
    target.hidden = expanded
  }
  button.onclick = listener
  listener()
}

ready(function () {
  initialiseselfActivity()
})
