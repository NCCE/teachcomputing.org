import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = { name: String, value: Boolean }

  static targets = ['source', 'button']

  removeAttribute() {
    this.buttonTarget.removeAttribute(this.nameValue)
  }

  addAttribute() {
    this.buttonTarget.setAttribute(this.nameValue, this.valueValue)
  }

  toggleAttribute() {
    const attributeExists = this.buttonTarget.getAttribute(this.nameValue)

    if (attributeExists) {
      this.removeAttribute()
    } else {
      this.addAttribute()
    }
  }

  /**
   * Workaround to reset the checked state if the browser history
   * is used, suggested solution is part way down this comment:
   * https://github.com/hotwired/stimulus/issues/328#issuecomment-722040944
   */
  resetCheckboxState() {
    if (this.sourceTarget.type !== 'checkbox') return

    if (this.sourceTarget.checked) {
      this.sourceTarget.checked = false
    }
  }
  pageShow() { this.resetCheckboxState() }
}
