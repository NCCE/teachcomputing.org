import Turbolinks from 'turbolinks'

export function onPageLoad(fn) {
  if (Turbolinks.supported) {
    window.addEventListener('turbolinks:load', fn)
  } else {
    window.addEventListener('DOMContentLoaded', fn)
  }
}
