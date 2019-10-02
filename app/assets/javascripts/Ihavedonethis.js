function initialiseselfActivity() {
  const wrapper = document.querySelector(
    '.ihavedonethis')
  if (!wrapper) {
    return
  }
  const button = wrapper.querySelector('button')
  const target = button.nextElementSibling


  wrapper.classList.toggle('ihavedonethis--progressive')

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
