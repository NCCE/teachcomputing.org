function closeOtherPopups(currentWrapper) {
  const wrappers = document.querySelectorAll(
    '.ihavedonethis')
  Array.prototype.forEach.call(wrappers, function iterateWrappers(wrapper) {
    if (wrapper != currentWrapper) {
      const button = wrapper.querySelector('button')
      const target = button.nextElementSibling
      button.setAttribute('aria-expanded', false)
      target.hidden = true
    }
  });
}

function initialiseIHaveDoneThisPopup() {
  const wrappers = document.querySelectorAll(
    '.ihavedonethis')

  Array.prototype.forEach.call(wrappers, function iterateWrappers(wrapper) {
    const button = wrapper.querySelector('button')
    const target = button.nextElementSibling

    wrapper.classList.toggle('ihavedonethis--progressive')

    const listener = function () {
      closeOtherPopups(wrapper);
      const expanded = button.getAttribute('aria-expanded') === 'true'
      button.setAttribute('aria-expanded', !expanded)
      target.hidden = expanded
    }
    button.onclick = listener
    listener()
  })
}

ready(function () {
  initialiseIHaveDoneThisPopup()
  closeOtherPopups(null);
})
