import ApplicationController from "../../webpacker/javascript/controllers/application_controller"

export default class EnrichmentListComponentController extends ApplicationController {

  static targets = ["termSelect", "ageGroupSelect", "typeSelect", "enrichment", "filterCount", "filterWrapper"];

  connect(){
  }

  filterChanged(){
    const filters = {
      term: this.termSelectTarget.value,
      ageGroup: this.ageGroupSelectTarget.value,
      type: this.typeSelectTarget.value
    };
    this.applyFilters(filters);
  }

  applyFilters({term, ageGroup, type}){
    let matchingCount = 0;

    this.enrichmentTargets.forEach(enrichment => {
      const termMatch = this.matchesFilter(enrichment.dataset.enrichmentTerms, term)
      const ageGroupMatch = this.matchesFilter(enrichment.dataset.enrichmentAgeGroups, ageGroup)
      const typeMatch = type === "" || enrichment.dataset.enrichmentType === type;
      if(termMatch && ageGroupMatch && typeMatch) {
        enrichment.classList.add("show")
        matchingCount++;
      } else {
        enrichment.classList.remove("show")
      }
    });
    this.updateFilterMessage(term, ageGroup, type, matchingCount);
  }

  matchesFilter(dataSet, filterValue) {
    return filterValue === "" || JSON.parse(dataSet).includes(filterValue);
  }

  updateFilterMessage(term, ageGroup, type, count) {
    if (term === "" && ageGroup === "" && type === "") {
      this.clearFilterMessage();
      return;
    }

    const message = count === 1 ? "1 activity found" : `${count} activities found`;
    this.filterCountTarget.innerText = message;
    this.filterWrapperTarget.classList.remove("hide");
  }

  clearFilterMessage(){
    this.filterWrapperTarget.classList.add("hide");
  }

  clearFilter() {
    this.termSelectTarget.selectedIndex = 0;
    this.ageGroupSelectTarget.selectedIndex = 0;
    this.typeSelectTarget.selectedIndex = 0;
    this.applyFilters({ term: "", ageGroup: "", type: ""});
  }

}
