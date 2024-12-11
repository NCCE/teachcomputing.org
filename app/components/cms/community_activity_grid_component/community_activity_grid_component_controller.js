import ApplicationController from "../../../webpacker/javascript/controllers/application_controller";

export default class extends ApplicationController {
  static values = {
    createPath: String,
  }
  static targets = ["activityButton", "activityTitle"]

  connect() {
    console.log("im here")
  }

  selectActivity(event) {
    fetch(this.createPathValue, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        achievement: {
          activity_id: event.params.activityId
        }
      })
    }).then((response) => {
      this.activityTitleTarget.innerText = event.params.activityTitle;
      this.dispatch("selected", {detail: {content: "ello"}})
    })
  }
}
