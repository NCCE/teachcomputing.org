import FieldHelper from './field_helpers';

document.addEventListener('DOMContentLoaded', function() {
  const button = document.getElementById('assign-activity-to-programme');

  if(button){
    const table = document.getElementById('activity-programme-table');
    const body = table.getElementsByTagName('tbody')[0];

    button.addEventListener('click', function() {
      const programmeSelect = document.getElementById('new_programme_assignment');
      const fh = new FieldHelper('activity', 'programme_activities_attributes');

      if(programmeSelect.value){
        const programmeOption = programmeSelect.options[programmeSelect.selectedIndex];

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
            programmeSelect.selectedIndex = 0;
          });
        })

      }


    });
  }

});
