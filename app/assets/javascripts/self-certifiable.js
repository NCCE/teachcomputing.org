function initialiseCollapsibleActivity() {
  const activity = document.querySelector(
    '.ncce-self-certifiable--add')
  if (!activity) {
    return
  }
  const button = activity.querySelector('button')
  const target = activity.nextElementSibling
  const hideButton = target.querySelector(
    'ncce-self-certifiable-collap__title-button')
  console.log('you there?')
  const wrapper = document.querySelector(
    '.ncce-activity-links')
  wrapper.classList.toggle('ncce-activity-links--progressive')

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
  initialiseCollapsibleActivity()
})
