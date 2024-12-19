import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class extends ApplicationController {
  static values = {
    achievementsPath: String,
    achievementId: String,
    activityId: String,
  }

  static targets = ["activityDetails", "activity"];

  selectActivity(event) {
    this.activityIdValue = event.target.value;
  }

  submitActivitySelection(event) {
    event.preventDefault()

    fetch(this.achievementsPathValue, {
        method: 'POST',
        headers: {
            'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            achievement: {
                activity_id: this.activityIdValue
            },
            enrol: true
        })
    })
    .then(() => {
        location.reload()
    })
  }

  deleteActivitySelection(event) {
    event.preventDefault()

    this.deletePath = this.achievementsPathValue + "/" + event.currentTarget.dataset.achievementId

    fetch(this.deletePath, {
        method: 'DELETE',
        headers: {
            'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
            'Content-Type': 'application/json'
        },
    })
    .then(() => {
        location.reload()
    })
  }
}
