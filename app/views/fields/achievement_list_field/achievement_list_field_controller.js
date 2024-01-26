import ApplicationController from "../../../webpacker/javascript/controllers/application_controller";

export default class extends ApplicationController {
  static targets = ['stateFilter', 'programmeFilter', 'achievement'];
  currentStateFilter = null;
  currentProgrammeFilter = null;

  initialize() {
  }
  
  filter() {
    this.currentStateFilter = this.stateFilterTarget.value;
    this.currentProgrammeFilter = this.programmeFilterTarget.value;
    this.toggleAchievements();
  }

  toggleAchievements(){
    console.log(this.currentProgrammeFilter);
    this.achievementTargets.forEach(element => {
      let stateHide = false
      let progHide = false
      if(this.currentStateFilter){
        stateHide = element.dataset.currentState !== this.currentStateFilter
      } 
      if(this.currentProgrammeFilter){
        progHide = !element.dataset.programmes.includes(this.currentProgrammeFilter)
      }
      element.hidden = stateHide || progHide
    });
  }


}
