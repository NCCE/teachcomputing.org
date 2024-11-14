import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class extends ApplicationController {
  static values = {
    createPath: String,
    achievementId: String,
    activityId: String,
  }

  static targets = ["activityDetails", "activity"];

  connect(){
  }

  selectActivity(event) {
    this.activityIdValue = event.target.value;
  }

  submitActivitySelection(event) {
    event.preventDefault()

    fetch(this.createPathValue, {
        method: 'POST',
        headers: {
            'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            achievement: {
                activity_id: this.activityIdValue
            }
        })
    })
    .then(() => {
        location.reload()
    })
  }
}
