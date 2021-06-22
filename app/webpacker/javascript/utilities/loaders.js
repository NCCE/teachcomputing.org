import Turbolinks from 'turbolinks'

export function onPageLoad(fn) {
  if (!fn) console.error('A function must be passed')

  if (Turbolinks.supported) {
    window.addEventListener('turbolinks:load', fn)
  } else {
    window.addEventListener('DOMContentLoaded', fn)
  }
}
