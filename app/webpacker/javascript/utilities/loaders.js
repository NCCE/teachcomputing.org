export function onPageLoad(fn) {
  window.addEventListener('DOMContentLoaded', fn)
  window.addEventListener('ajax:success', fn)
}
