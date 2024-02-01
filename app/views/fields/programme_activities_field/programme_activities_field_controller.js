import ApplicationController from "../../../webpacker/javascript/controllers/application_controller";
import FieldHelper from "../../../webpacker/javascript/administrate/fields/field_helpers"

export default class extends ApplicationController {

  static targets = ['programmeSelect', 'programmeTable'];

  addNewProgramme(){
    const fh = new FieldHelper('activity', 'programme_activities_attributes');

    if(this.programmeSelectTarget.value){
      const programmeOption = this.programmeSelectTarget.options[this.programmeSelectTarget.selectedIndex];

      const body = this.programmeTableTarget.getElementsByTagName('tbody')[0];
      let tableRow = document.createElement('tr');
      const index = body.rows.length;

      fetch('/admin/programmes/'+programmeOption.value+'/groups', {
        headers: {
          'Content-Type': 'application/json;charset=utf-8'
        },
      }).then(response => {
        response.json().then(data => {
          const cells = [];
          const optionsWithBlank = [[ 'No Group', null ]];
          data.forEach((item) => {
            optionsWithBlank.push([item.title, item.id]);
          })
          cells.push(fh.createCellText(programmeOption.text));
          cells.push(fh.createCell(fh.createSelect('programme_activity_grouping_id', optionsWithBlank, index)));
          cells.push(fh.createCell(fh.createCheckBoxCell('legacy', index)));
          cells.push(fh.createCell(fh.createCheckBoxCell('_destroy', index)));
          cells[0].appendChild(fh.createHiddenFields('programme_id', programmeOption.value, index));

          cells.forEach(function(cell) {
            tableRow.appendChild(cell);
          });

          body.appendChild(tableRow);

          programmeOption.setAttribute('disabled', 'disable');
          this.programmeSelectTarget.selectedIndex = 0;
        });
      })

    }


  } 
}

