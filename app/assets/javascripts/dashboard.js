function initialiseCollapsibleActivity() {
  const activity = document.querySelector(
    '.ncce-activity-links--add')

  const button = activity.querySelector('button')
  const target = activity.nextElementSibling
  const hideButton = target.querySelector('.ncce-collapsible-activity__title-button')

  const wrapper = document.querySelector(
    '.ncce-activity-links')
  wrapper.classList.toggle('ncce-activity-links--progressive')

  target.classList.toggle('ncce-collapsible-activity--progressive')

  const listener = () => {
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
