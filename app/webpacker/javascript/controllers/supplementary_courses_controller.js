import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['expander', 'expanderButton']

  initialize() {
    this.toggleAriaHidden(this.expanderButtonTarget)
    this.toggleHidden(this.expanderTarget)
  }

  toggleAll() {
    this.toggleAriaHidden(this.expanderButtonTarget)
    this.toggleHidden(this.expanderTarget)
  }

  toggleAriaHidden(element) {
    if(element.getAttribute('aria-expanded') === 'true') {
      element.setAttribute('aria-expanded', 'false')
    } else {
      element.setAttribute('aria-expanded', 'true')
    }
  }

  toggleHidden(element) {
    let classes = element.classList
    classes.contains('hidden')
      ? classes.remove('hidden')
      : classes.add('hidden')
  }
}
