// content:updated is dispatched after JS replaces part of the page (e.g. course filter results)
export function onPageLoad(fn) {
  window.addEventListener('DOMContentLoaded', fn)
  window.addEventListener('content:updated', fn)
}
