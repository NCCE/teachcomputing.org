import ApplicationController from "../../../webpacker/javascript/controllers/application_controller";

export default class extends ApplicationController {
  static values = {
    createPath: String,
    slug: String
  }
  static targets = ["activityButton", "activityTitle", "activityBox", "activityGrid"];

  selectActivity(event) {
    console.log(event);
    const activityId = event.params.activityId;
    fetch(this.createPathValue, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').content,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        achievement: {
          activity_id: activityId
        },
        enrol: true
      })
    }).then((response) => {
      this.activityTitleTarget.innerText = event.params.activityTitle;
      this.dispatch("selected", {detail: {key: this.slugValue}}); 
      const box = this.findActivityBox(activityId);
      if(box){
        box.classList.add("community-activity-grid__grid-activity--started");
        this.element.classList.add("community-activity-grid--chosen")
        this.activityGridTarget.prepend(box);
      }
    })
  }

  findActivityBox(id){
    return this.activityBoxTargets.find(element => element.dataset.id == id)
  }
}
