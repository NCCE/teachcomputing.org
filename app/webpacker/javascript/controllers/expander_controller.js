import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['expander', 'expanderButton']

  connect() {
    const startExpanded = this.expanderButtonTarget.getAttribute('start-expanded');
    if (!startExpanded || startExpanded == 'false') {
      this.collapse()
    }
  }

  collapse() {
    let classes = this.expanderTarget.classList
    if (!classes.contains('hidden')) {
      classes.add('hidden')
    }
    this.expanderButtonTarget.setAttribute('aria-expanded', 'false')
  }

  expand() {
    this.expanderTarget.classList.remove('hidden')
    this.expanderButtonTarget.setAttribute('aria-expanded', 'true')
  }

  toggleAll() {
    let expanded = this.expanderButtonTarget.getAttribute('aria-expanded')
    if (expanded === 'true') {
      this.collapse()
    } else {
      this.expand()
    }
  }

  stopEventBubbling(ev) {
    ev.stopPropagation()
  }
}
