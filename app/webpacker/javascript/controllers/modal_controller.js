import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ['modal']

  connect() {
    this.element.addEventListener('keydown', this.onKeyDown.bind(this))
  }

  disconnect() {
    this.element.removeEventListener(this.onKeyDown)
  }

  toggle() {
    this.modalTarget.classList.toggle('ncce-modal--expanded')
  }

  onKeyDown(event) {
    if (event.key === 'Escape') {
      if (this.modalTarget.classList.contains('ncce-modal--expanded')) {
        if (!this.modalTarget.querySelector('ncce-modal--expanded')) {
          event.stopPropagation()
          this.toggle()
        }
      }
    }
  }
}
