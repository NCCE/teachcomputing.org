import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = { name: String }

  static targets = ['submit']

  initialize() {
    this.submitTarget.setAttribute(this.nameValue, true)
  }

  toggleAttribute() {
    if (this.submitTarget.getAttribute(this.nameValue)) {
      this.submitTarget.removeAttribute(this.nameValue)
    } else {
      this.submitTarget.setAttribute(this.nameValue, true)
    }
  }
}
