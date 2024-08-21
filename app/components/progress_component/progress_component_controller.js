import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class ProgressComponentController extends ApplicationController {
  static targets = ["counter", "back", "continue", "submit", "step", "warning"]

  connect() {
    if (this.stepTargets.length == 0) throw new Error("Must have at least one step")
    this.currentStep = 0
    this.updateCounter()
    this.updateButtonVisibility()
    this.updateStepsVisibility()
    this.updateWarningStepVisibility()
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

  updateWarningStepVisibility() {
    this.warningTarget.classList.toggle("active", this.currentStep == this.stepTargets.length - 1)
  }

  updateSection() {
    this.updateCounter()
    this.updateButtonVisibility()
    this.updateStepsVisibility()
    this.updateWarningStepVisibility()
  }

  back() {
    if (this.currentStep == 0) return

    this.currentStep -= 1
    this.updateSection()
  }

  continue() {
    if (this.currentStep == this.stepTargets.length - 1) return

    this.currentStep += 1
    this.updateSection()
  }

  jumpToSection(event) {
    const targetStep = event.params.targetStep

    this.currentStep = targetStep
    this.updateSection()
  }
}
