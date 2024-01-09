import FieldHelper from './field_helpers';

document.addEventListener('DOMContentLoaded', function() {
  const button = document.getElementById('pathway-add-new');

  if(button){
    const table = document.getElementById('table-for-pathway');
    const body = table.getElementsByTagName('tbody')[0];
    const fh = new FieldHelper('activity', 'pathway_activities_attributes');

    button.addEventListener('click', function() {
      let form = document.getElementById(button.dataset.formId);
      let select = document.getElementById('new_pathway');

      if(select.value){
        let pathway = select.options[select.selectedIndex];
        pathway.setAttribute('disabled', 'disable');

        let tableRow = document.createElement('tr');
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

    });
  }
});



