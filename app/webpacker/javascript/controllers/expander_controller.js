import { Controller } from 'stimulus'

export default class extends Controller {
  static values = {
    expand: String,
    colapse: String
  }

  static targets = ['expander', 'expanderButton', 'expanderButtonText']

  connect() {
    const startExpanded = this.expanderButtonTarget.getAttribute('start-expanded')
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

    if (this.hasExpanderButtonTextTarget) {
      this.expanderButtonTextTarget.innerText = this.expandValue
    }
  }

  expand() {
    this.expanderTarget.classList.remove('hidden')
    this.expanderButtonTarget.setAttribute('aria-expanded', 'true')

    if (this.hasExpanderButtonTextTarget) {
      this.expanderButtonTextTarget.innerText = this.colapseValue
    }
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
