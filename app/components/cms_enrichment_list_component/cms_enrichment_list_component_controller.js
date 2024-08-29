import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class CmsEnrichmentListComponentController extends ApplicationController {

  static targets = ["termSelect", "ageGroupSelect", "typeSelect", "enrichment"];

  connect(){
  }

  filterChanged(event){
    const termFilter = this.termSelectTarget.value;
    const ageGroupFilter = this.ageGroupSelectTarget.value;
    const typeFilter = this.typeSelectTarget.value;
    this.enrichmentTargets.forEach(enrichment => {
      const termMatch = termFilter != "" ? JSON.parse(enrichment.dataset.enrichmentTerms).includes(termFilter) : true;
      const ageGroupMatch = ageGroupFilter != "" ? JSON.parse(enrichment.dataset.enrichmentAgeGroups).includes(ageGroupFilter) : true;
      const typeMatch = typeFilter != "" ? enrichment.dataset.enrichmentType === typeFilter : true;
      if(termMatch && ageGroupMatch && typeMatch) {
        enrichment.classList.add("show")
      } else {
        enrichment.classList.remove("show")
      }
    });
  }
  
}