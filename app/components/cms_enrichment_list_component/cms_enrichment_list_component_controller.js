import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class CmsEnrichmentListComponentController extends ApplicationController {

  static targets = ["termSelect", "ageGroupSelect", "typeSelect", "enrichment", "filterCount", "filterWrapper"];

  connect(){
  }

  filterChanged(){
    const termFilter = this.termSelectTarget.value;
    const ageGroupFilter = this.ageGroupSelectTarget.value;
    const typeFilter = this.typeSelectTarget.value;
    console.log(termFilter == "")
    let count = 0;
    this.enrichmentTargets.forEach(enrichment => {
      const termMatch = termFilter != "" ? JSON.parse(enrichment.dataset.enrichmentTerms).includes(termFilter) : true;
      const ageGroupMatch = ageGroupFilter != "" ? JSON.parse(enrichment.dataset.enrichmentAgeGroups).includes(ageGroupFilter) : true;
      const typeMatch = typeFilter != "" ? enrichment.dataset.enrichmentType === typeFilter : true;
      if(termMatch && ageGroupMatch && typeMatch) {
        console.log("showing")
        enrichment.classList.add("show")
        count++;
      } else {
        enrichment.classList.remove("show")
      }
    });
    let message; 
    if (count == 1){
      message = "1 activity found";
    } else {
      message = `${count} activities found`;
    }
    this.filterCountTarget.innerText = message;
    this.filterWrapperTarget.classList.remove("hide");
  }

  clearFilter() {
    this.termSelectTarget.selectedIndex = 0;
    this.ageGroupSelectTarget.selectedIndex = 0;
    this.typeSelectTarget.selectedIndex = 0;
    this.filterChanged();
    this.filterWrapperTarget.classList.add("hide");
  }
  
}