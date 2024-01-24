import ApplicationController from "../../../webpacker/javascript/controllers/application_controller";

export default class extends ApplicationController {
  static targets = ['stateFilter', 'achievement'];
  currentStateFilter = null;

  initialize() {
  }
  
  filter() {
    this.currentStateFilter = this.stateFilterTarget.value;
    console.log(this.currentStateFilter)
    this.toggleAchievements();
  }

  toggleAchievements(){
    this.achievementTargets.forEach(element => {
      let hide = false
      if(this.currentStateFilter){
        hide = element.dataset.currentState !== this.currentStateFilter
      } 
      element.hidden = hide
    });
  }


}
