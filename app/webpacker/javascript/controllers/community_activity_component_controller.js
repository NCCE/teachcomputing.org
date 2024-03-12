import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = {
    createPath: String,
    updatePath: String,
    achievementsSubmitPath: String,
    achievementId: String,
    activityId: String,
  }
  static targets = ["textarea"]

  trackUnsavedChanges() {
    this.initialValues = new Map()
    this.toggleConfirmationEnabled = () => {
      const allValuesAreInitial = this.textareaTargets.every(element => element.value == this.initialValues.get(element))
      const parentModal = this.element.querySelector("[data-controller='modal']")
      if (parentModal == null) return

      parentModal.setAttribute("data-modal-confirm-value", !allValuesAreInitial)
    }

    this.textareaTargets.forEach(input => {
      this.initialValues.set(input, input.value)
      input.addEventListener("input", this.toggleConfirmationEnabled)
    })

    this.toggleConfirmationEnabled()
  }

  connect() {
    this.trackUnsavedChanges()
  }

  disconnect() {
    this.textareaTargets.forEach(element => element.removeEventListener("input", this.toggleConfirmationEnabled))
  }

  saveAsDraft() {
    let path = ''
    let method = ''

    if (this.achievementIdValue === '') {
      path = this.createPathValue
      method = 'POST'
    } else {
      path = this.updatePathValue
      method = 'PUT'
    }

    fetch(path, {
      method: method,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        achievement: {
          evidence: this.textareaTargets.map(element => element.value),
          activity_id: this.activityIdValue
        }
      })
    }).then((response) => {
      location.reload()
    })
  }

  submit() {
    fetch(this.achievementsSubmitPathValue, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        achievement: {
          evidence: this.textareaTargets.map(element => element.value),
          activity_id: this.activityIdValue
        }
      })
    }).then((response) => {
      location.reload()
    })
  }
}
