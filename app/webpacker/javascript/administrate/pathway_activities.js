
document.addEventListener('DOMContentLoaded', function() {
  const button = document.getElementById('pathway-add-new');

  if(button){
    const table = document.getElementById('table-for-pathway');
    const body = table.getElementsByTagName('tbody')[0];

    button.addEventListener('click', function() {
      let form = document.getElementById(button.dataset.formId);
      let select = document.getElementById('new_pathway');

      if(select.value){
        let pathway = select.options[select.selectedIndex];

        let tableRow = document.createElement('tr');
        const index = body.childNodes.length;

        const cells = [];
        cells.push(createCell(pathway.dataset.programmeTitle));
        cells.push(createCell(pathway.dataset.title));
        cells.push(createCheckBoxCell(index, 'supplementary'));
        cells.push(createCheckBoxCell(index, '_destroy'));
        cells[0].appendChild(createHiddenFields(index, 'pathway_id', pathway.value));

        cells.forEach(function(cell) {
          tableRow.appendChild(cell);
        });

        body.appendChild(tableRow);
      }

    });
  }
});

function createCell(data) {
  let cell = document.createElement('td');
  cell.innerHTML = data;
  return cell;
}

function createCheckBoxCell(index, attribute) {
  let input = document.createElement('input');
  input.setAttribute('name', 'activity[pathway_activities_attributes][' + index + '][' + attribute + ']');
  input.setAttribute('type', 'checkbox');
  let cell = document.createElement('td');
  cell.appendChild(input);
  return cell;
}

function createHiddenFields(index, attributeName, value) {
  let input = document.createElement('input');
  input.setAttribute('type', 'hidden');
  input.setAttribute('name', 'activity[pathway_activities_attributes][' + index + ']['+ attributeName +']');
  input.setAttribute('value', value);
  return input;
}
