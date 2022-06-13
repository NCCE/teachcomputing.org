import '@rails/activestorage'
import { onPageLoad } from './utilities/loaders';

function closePopups(currentWrapper = null) {
  const wrappers = document.querySelectorAll('.ihavedonethis')
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
  const wrappers = document.querySelectorAll('.ihavedonethis')

  Array.prototype.forEach.call(wrappers, function iterateWrappers(wrapper) {
    const button = wrapper.querySelector('button')
    const target = button.nextElementSibling

    wrapper.classList.toggle('ihavedonethis--progressive')

    const listener = () => {
      closePopups(wrapper);
      const expanded = button.getAttribute('aria-expanded') === 'true'
      button.setAttribute('aria-expanded', !expanded)
      target.hidden = expanded
    }
    button.onclick = listener
    listener()
  })
}

onPageLoad(() => {
  initialiseIHaveDoneThisPopup()
  closePopups() // Ensure no popups are open on page load

  // Close popups when clicking anywhere outside of a popup
  window.onclick = ev => {
    if (ev.target.closest('.ihavedonethis')) return
    closePopups()
  }
})
