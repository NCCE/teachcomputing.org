import ApplicationController from "../../../webpacker/javascript/controllers/application_controller";
import FieldHelper from "../../../webpacker/javascript/administrate/fields/field_helpers"

export default class extends ApplicationController {

  static targets = ['pathwayTable', 'pathwaySelect'];


  addNewPathway() {
    const fh = new FieldHelper('activity', 'pathway_activities_attributes');
    if(this.pathwaySelectTarget.value){
      let pathway = this.pathwaySelectTarget.options[this.pathwaySelectTarget.selectedIndex];
      pathway.setAttribute('disabled', 'disable');

      const tableRow = document.createElement('tr');
      const body = this.pathwayTableTarget.getElementsByTagName('tbody')[0];
      const index = body.rows.length;

      const cells = [];
      cells.push(fh.createCellText(pathway.dataset.programmeTitle));
      cells.push(fh.createCellText(pathway.dataset.title));
      cells.push(fh.createCell(fh.createCheckBoxCell('supplementary', index)));
      cells.push(fh.createCell(fh.createCheckBoxCell('_destroy', index)));
      cells[0].appendChild(fh.createHiddenFields('pathway_id', pathway.value, index));

      cells.forEach(function(cell) {
        tableRow.appendChild(cell);
      });
      body.appendChild(tableRow);
    }

  }

}



