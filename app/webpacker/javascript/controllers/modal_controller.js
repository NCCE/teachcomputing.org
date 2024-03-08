import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ['modal']

  connect() {
    document.body.addEventListener('keydown', this.onKeyDown.bind(this))
    this.modalTarget.addEventListener("click", this.onClick.bind(this))
  }

  disconnect() {
    document.body.removeEventListener(this.onKeyDown)
    this.modalTarget.removeEventListener("click", this.onClick.bind(this))
  }

  toggle() {
    this.modalTarget.classList.toggle('ncce-modal--expanded')
  }

  onClick(event) {
    if (event.target.classList.contains("ncce-modal--expanded")) {
      this.toggle()
    }
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
