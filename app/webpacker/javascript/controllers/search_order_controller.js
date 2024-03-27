import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  connect() {
    this.element.addEventListener('change', this.onChange.bind(this))
  }

  disconnect() {
    this.element.removeEventListener(this.onChange)
  }

  onChange(event) {
    const urlParams = new URLSearchParams(window.location.search)
    urlParams.set('order', event.target.value)
    window.location.href = `search?${urlParams.toString()}`
  }
}
