import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = {
    createPath: String,
    updatePath: String,
    achievementsSubmitPath: String,
    achievementId: String,
    activityId: String,
  }
  static targets = ['textarea']

  saveAsDraft() {
    let path = ''
    let method = ''

    console.log(this.createPathValue)
    console.log(this.updatePathValue)

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
          self_verification_info: this.textareaTarget.value,
          activity_id: this.activityIdValue
        }
      })
    }).then((response) => {
      if (response.redirected) {
        location.href = response.url
      }
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
          self_verification_info: this.textareaTarget.value,
          activity_id: this.activityIdValue
        }
      })
    }).then((response) => {
      if (response.redirected) {
        location.href = response.url
      }
    })
  }
}
