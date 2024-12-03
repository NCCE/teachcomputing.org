import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = {
    createPath: String,
  }
  static targets = ["activityButton"]

  selectActivity() {
    fetch(this.createPathValue, {
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
