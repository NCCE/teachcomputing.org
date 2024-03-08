import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class ProgressComponentController extends ApplicationController {
  static targets = ["counter", "back", "continue", "submit", "step"]

  connect() {
    if (this.stepTargets.length == 0) throw new Error("Must have at least one step")
    this.currentStep = 0
    this.updateCounter()
    this.updateButtonVisibility()
    this.updateStepsVisibility()
  }

  updateCounter() {
    this.counterTarget.textContent = `${this.currentStep + 1} of ${this.stepTargets.length}`
  }

  updateButtonVisibility() {
    this.backTarget.classList.toggle("active", this.currentStep > 0)
    this.continueTarget.classList.toggle("active", this.currentStep < this.stepTargets.length - 1)
    this.submitTarget.classList.toggle("active", this.currentStep == this.stepTargets.length - 1)
  }

  updateStepsVisibility() {
    this.stepTargets.forEach((step, i) => {
      step.classList.toggle("active", i == this.currentStep)
    })
  }

  back() {
    if (this.currentStep == 0) return

    this.currentStep -= 1
    this.updateCounter()
    this.updateButtonVisibility()
    this.updateStepsVisibility()
  }

  continue() {
    if (this.currentStep == this.stepTargets.length - 1) return

    this.currentStep += 1
    this.updateCounter()
    this.updateButtonVisibility()
    this.updateStepsVisibility()
  }

  submit() {
    if (this.currentStep != this.stepTargets.length - 1) return

    this.submitTarget.dispatchEvent(
      new CustomEvent("submit", {
        cancelable: true,
        bubbles: true,
    }))
  }
}
