function initialiseselfActivity() {
  const activity = document.querySelector(
    '.ncce-self-certifiable-links--add')
  if (!activity) {
    return
  }
  const button = activity.querySelector('button')
  const target = activity.nextElementSibling
  const hideButton = target.querySelector(
    '.ncce-self-certifiable__title-button')

  const wrapper = document.querySelector(
    '.ncce-self-certifiable-links')
  wrapper.classList.toggle('ncce-self-certifiable-links--progressive')

  target.classList.toggle('ncce-self-certifiable--progressive')

  const listener = function () {
    const expanded = button.getAttribute('aria-expanded') === 'true'
    button.setAttribute('aria-expanded', !expanded)
    target.hidden = expanded
  }
  button.onclick = listener
  hideButton.onclick = listener
  listener()
}

ready(function () {
  initialiseselfActivity()
})
