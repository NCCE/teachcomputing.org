import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = {
    createPath: String,
    updatePath: String,
    achievementsSubmitPath: String,
    achievementId: String,
    activityId: String,
    minimumEvidenceLength: { type: Number, default: 0 }
  }
  static targets = ["textarea", "submitButton", "saveDraftButton", "completionWarningMessage", "characterCountMessage"]

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
    this.checkForEvidence();
    this.trackCharacterCount()
  }

  trackCharacterCount() {
    this.updateCharacterCount = (element, index) => {
      const remainingCharacters = this.minimumEvidenceLengthValue - element.value.length

      if(element.value.length > 0 && element.value.length < this.minimumEvidenceLengthValue) {
        this.characterCountMessageTargets[index].textContent = `Provide at least ${remainingCharacters} more characters`
      } else {
        this.characterCountMessageTargets[index].textContent = ""
      }

    };

    this.textareaTargets.forEach((input, index) => {
      input.addEventListener("input", () => this.updateCharacterCount(input, index))
    });

    this.textareaTargets.forEach((input, index) => {
      this.updateCharacterCount(input, index)
    });
  }

  checkForEvidence() {
    this.hasEvidence = () => {
      const hasAnyValue = this.textareaTargets.some(element => element.value !== "")
      const missingValues = []
      this.textareaTargets.forEach((element, index) => {
        if(element.value.length < this.minimumEvidenceLengthValue){
          missingValues.push(index)
        }
      })
      if(this.hasSubmitButtonTarget) {
        if(missingValues.length == 0){
          this.submitButtonTarget.removeAttribute('disabled')
        } else {
          this.submitButtonTarget.setAttribute('disabled', '')
        }
      }
      if(this.hasSaveDraftButtonTarget) {
        if(hasAnyValue){
          this.saveDraftButtonTarget.removeAttribute('disabled')
        } else {
          this.saveDraftButtonTarget.setAttribute('disabled', '')
        }
      }
      if(this.hasCompletionWarningMessageTarget) {
        if(missingValues.length > 0) {
          this.completionWarningMessageTarget.innerHTML = 'You are missing some evidence in section ' + missingValues.map(index => {
            const sectionNumber = index + 1
            return `<a class='community-activity-component__section-link' data-action='progress-component#jumpToSection' data-progress-component-target-step-param='${index}'> ${sectionNumber}</a>`
          }).join(', ')
        } else {
          this.completionWarningMessageTarget.innerHTML = ''
        }
      }
    }

    this.textareaTargets.forEach(input => {
      input.addEventListener("input", this.hasEvidence)
    })

    this.hasEvidence()
  }

  disconnect() {
    this.textareaTargets.forEach(element => {
      element.removeEventListener("input", this.toggleConfirmationEnabled)
      element.removeEventListener("input", this.hasEvidence)
      element.removeEventListener("input", this.updateCharacterCount)
    })
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

  submit(event) {
    const achievement = {
      evidence: this.textareaTargets.map(element => element.value),
      activity_id: this.activityIdValue,
    }
    if(event.params.slug) {
      achievement['submission_option'] = event.params.slug
    }
    fetch(this.achievementsSubmitPathValue, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        achievement: achievement
      })
    }).then((response) => {
      if(event.params.redirect) {
        window.open(event.params.redirect, "_blank").focus();
      }
      location.reload();
    })
  }
}
