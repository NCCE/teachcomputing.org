// Replaces Rails UJS's data-disable-with (added to submit buttons by submit_tag/f.submit), which stopped
// double submits. Turbo only does this for forms it submits itself, and Drive is off on public pages.

const disabledButtons = new Set()

document.addEventListener('submit', event => {
  if (event.defaultPrevented) return

  const buttons = event.target.querySelectorAll('[data-disable-with]')

  // Deferred so the browser has already captured the clicked button's name/value for the request
  setTimeout(() => {
    buttons.forEach(button => {
      button.dataset.enableWith = button.tagName === 'INPUT' ? button.value : button.innerHTML
      if (button.tagName === 'INPUT') {
        button.value = button.dataset.disableWith
      } else {
        button.innerHTML = button.dataset.disableWith
      }
      button.disabled = true
      disabledButtons.add(button)
    })
  })
})

// Pages restored from the back/forward cache would otherwise keep their buttons disabled
window.addEventListener('pageshow', () => {
  disabledButtons.forEach(button => {
    if (button.tagName === 'INPUT') {
      button.value = button.dataset.enableWith
    } else {
      button.innerHTML = button.dataset.enableWith
    }
    button.disabled = false
  })
  disabledButtons.clear()
})
