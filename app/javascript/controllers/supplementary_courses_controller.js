import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['expander', 'showButton', 'hideButton']

  initialize() {
    this.toggleVisuallyHidden(this.expanderTarget)
    this.toggleHidden(this.showButtonTarget)
  }

  toggleAll() {
    this.toggleVisuallyHidden(this.expanderTarget)
    this.toggleHidden(this.showButtonTarget)
    this.toggleHidden(this.hideButtonTarget)
  }

  toggleVisuallyHidden(element) {
    let classes = element.classList
    classes.contains('visually-hidden')
      ? classes.remove('visually-hidden')
      : classes.add('visually-hidden')
  }

  toggleHidden(element) {
    let classes = element.classList
    classes.contains('hidden')
      ? classes.remove('hidden')
      : classes.add('hidden')
  }
}
